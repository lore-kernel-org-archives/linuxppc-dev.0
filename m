Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: miguel.valero@axxessit.no
To: linuxppc-embedded@lists.linuxppc.org
Subject: DS1340 RTC (i2c device)
Message-ID: <OFBE3E7E82.C477AD44-ONC1256ED6.0024E631@axxessit.no>
Date: Mon, 19 Jul 2004 08:44:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone have any good suggestions about how to handle an i2c RTC
device, as f.e. the Maxim ds1340 ?

As far as I can understand, the "todc_time" component only supports memory
mapped RTC devices.

I believe I have to implement my own, platform dependent, "time_init",
"set_rtc_time" and "get_rtc_time" functions, and register them in the
ppc_md structure during platform initialisation.

I also believe that "time_init" and "get_rtc_time" are called by the
kernel rather early.

The question is whether the i2c driver is already in place by the time
these functions are called, so that I can register a driver for the
ds1340.
Has anyone done something like that ?
If I am on the wrong track, can someone give me a good hint ?

Regards
Miguel A. Valero
R & D Engineer
------------------------------------------------------------------------------------------------------
AXXESSIT ASA
PB 219 Økern
Risløkkveien 2 N-0510 Oslo
------------------------------------------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
