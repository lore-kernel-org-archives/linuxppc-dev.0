Return-Path: <tony.p.lee@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id 6B1652BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jan 2005 14:36:41 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id a36so66124rnf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 08 Jan 2005 19:36:40 -0800 (PST)
Message-ID: <470b639705010819304b3b3118@mail.gmail.com>
Date: Sat, 8 Jan 2005 19:30:00 -0800
From: Tony Lee <tony.p.lee@gmail.com>
To: Robin <robin@india.tejasnetworks.com>
In-Reply-To: <41DE3A2A.3050105@india.tejasnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050106121238.BB99AC108D@atlas.denx.de>
	<41DC9568.6090106@india.tejasnetworks.com>
	<Pine.LNX.4.61.0501061450190.4945@mag.sysgo.com>
	<41DE3A2A.3050105@india.tejasnetworks.com>
Cc: Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: TZ variable setting for denx 2.4.20
Reply-To: Tony Lee <tony.p.lee@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What's denx?
Anyway, in my embeded ppc-linux, I set it with 
/etc/TZ

echo "PST8PDT" > /etc/TZ to set it to pacific time.

Have fun.

-Tony


On Fri, 07 Jan 2005 12:58:42 +0530, Robin <robin@india.tejasnetworks.com> wrote:
> Hi
> Thanx for your response. I am setting TZ variable as
> given in the documentation.
>    export TZ="xxx5:30yyy4:30,M10.1.1,M2.1.1"
> Its working fine till Dec 31 23:59:59GMT. On Jan 01 00:00:00,
>  its not taking DST into account at all.
> 
> Please tell me some way of setting it across an year boundary.
> Thanks,
> Robin
> 
> Marius Groeger wrote:
> 
> > Robin,
> >
> > On Thu, 6 Jan 2005, Robin wrote:
> >
> >> I have tried with the standard linux date too. That too doesnt seem
> >> to consider timezone variable that has been set. Can you give me a
> >> way for setting timezone for southern hemisphere countries?? The
> >> busybox code uses strftime function. But that does not seem to
> >> consider TZ variable...
> >
> >
> > You should read up on how glibc handles all that timezone stuff:
> >
> >   sh# info libc "TZ Variable"
> >
> > Most notably, make sure you /etc/localtime is set up correctly. There
> > is also a tool (script) called tzselect which may be helpful for you.
> >
> > Note I'm not exactly an expert on this, I'm just giving pointers...
> >
> > Regards,
> > Marius
> >
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


-- 
-Tony
Having fun with FPGA HW + ppc + Linux
