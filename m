Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46FD5604.3060104@am.sony.com>
Date: Fri, 28 Sep 2007 12:29:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
References: <20070926163308.772580000@pademelon.sonytel.be>	
	<1190860285.6502.6.camel@concordia> <46FBE6FD.3030605@am.sony.com>
	<1190968833.15970.3.camel@concordia>
In-Reply-To: <1190968833.15970.3.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2007-09-27 at 10:23 -0700, Geoff Levand wrote:
>> Michael Ellerman wrote:
>> > On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
>> >> Question: As several DVI-D displays advertise they support 1080i modes while
>> >> they actually don't (cfr. the quirk database), perhaps I should drop 1080i
>> >> modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
>> >> better than 1080i anyway.  What do you think?
>> > 
>> > Definitely. If the autodetection fails Linux is basically unusable on
>> > PS3 unless you hack the kernel sources and build your own kboot and
>> > otheros.bld - not entirely trivial for novice users. So it's pretty
>> > important that it works 100%.
>> 
>> It is not that bad.  If a bootloader is configued to use autodetection
>> so that it is shown at best video mode, then it should have advertised
>> key sequences to default to known video modes, with at least a 480p 'safe'
>> mode.
> 
> Oh OK, that is a good idea. What's the "safe mode" key sequence for the
> otheros.bld you provide on kernel.org?


I don't maintain that, and have no idea how it sets its video mode.  Did you
have trouble with it?  I know in the past it used a fixed 480p mode. 


-Geoff
