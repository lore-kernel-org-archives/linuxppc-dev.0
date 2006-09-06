Return-Path: <netstv@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id 69F4767B95
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 07:20:31 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i4so902679wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Sep 2006 14:20:30 -0700 (PDT)
Message-ID: <b4b98b690609061420j4a790227jbac4a681136dc52a@mail.gmail.com>
Date: Wed, 6 Sep 2006 14:20:30 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Clint Thomas" <cthomas@soneticom.com>
Subject: Re: Continuous Login Loop
In-Reply-To: <3C02138692C13C4BB675FE7EA24095291C3C92@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3C02138692C13C4BB675FE7EA24095291C3C92@bluefin.Soneticom.local>
Cc: Jason Lamb <JLamb@soneticom.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/6/06, Clint Thomas <cthomas@soneticom.com> wrote:
>
>
> Hey,
>
> I'm running the latest kernel pull from the mvista powerpc 2.4 dev source. I
> built a root file system using Busybox 1.2.0 and the mkrootfs script by
> Wolfgang Klingauf (removed all DOS carriage returns). When the system boots
> up, i'm getting this output.
>
> Mounted devfs on /dev
> Freeing unused kernel memory: 44k init
> init started:  BusyBox v1.2.0 (2006.09.06-19:44+0000) multi-call binary
> Starting pid 10, console /dev/console: '/etc/init.d/rcS'
> Bummer, could not run '/etc/
> PowerPC Linux 2.4.26
> (none) login: root
> Process '/sbin/getty 38400 tts/0' (pid 11) exited.  Scheduling i
> PowerPC Linux 2.4.26
> (none) login:
>
> it keeps looping through the login every time I try to enter root. I have
> the root user in the passwd file, and I believe I have the RFS setup
> properly. What would cause this kind of an issue? Is this a problem related
> to getty? or just a missing file or device of some kind? Thanks
>

Hi Clint,

You know in the back of my head (very dusty place) I seem to recall
that this is a Busybox issue with getty.  Something about security.
Not sure... but I'd check with their forums.

-stv
>
>
> Clinton Thomas
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
