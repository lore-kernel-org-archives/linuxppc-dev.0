Message-ID: <40FB7103.5010603@246tNt.com>
Date: Mon, 19 Jul 2004 08:58:11 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: miguel.valero@axxessit.no
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DS1340 RTC (i2c device)
References: <OFBE3E7E82.C477AD44-ONC1256ED6.0024E631@axxessit.no>
In-Reply-To: <OFBE3E7E82.C477AD44-ONC1256ED6.0024E631@axxessit.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I'm also planning on using this chip as RTC. The solution I've come up
with currently is to use the RTC that is on the chip (but it doesn't
keep correct time between boots), but leave it uninitialized (  1 Jan
1970 ), then in userspace, read the external RTC and set the correct
time during boot.

Sylvain Munaut

miguel.valero@axxessit.no wrote:

 > Does anyone have any good suggestions about how to handle an i2c
 > RTC device, as f.e. the Maxim ds1340 ?
 >
 > As far as I can understand, the "todc_time" component only supports
 > memory mapped RTC devices.
 >
 > I believe I have to implement my own, platform dependent,
 > "time_init", "set_rtc_time" and "get_rtc_time" functions, and
 > register them in the ppc_md structure during platform
 > initialisation.
 >
 > I also believe that "time_init" and "get_rtc_time" are called by
 > the kernel rather early.
 >
 > The question is whether the i2c driver is already in place by the
 > time these functions are called, so that I can register a driver
 > for the ds1340. Has anyone done something like that ? If I am on
 > the wrong track, can someone give me a good hint ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
