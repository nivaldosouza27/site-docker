import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { resolve } from 'path';
import { AppController } from './app.controller';
import { AppService } from './app.service';

const envPath = resolve(__dirname, `../.env.${process.env.ENV || 'dev'}`);

@Module({
  imports: [
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: envPath,
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
