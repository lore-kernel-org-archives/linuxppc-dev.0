To: mgreer@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mcpn765
References: <yx2r8zzghpd.fsf@aste15.ida.liu.se> <3AB0EA13.B893E257@mvista.com>
	<200103151827.TAA26091@aste15.ida.liu.se>
	<3AB10B99.B5C43C07@mvista.com>
From: bjowi@ida.liu.se (=?iso-8859-1?q?Bj=F6rn?= Wingman)
Date: 16 Mar 2001 19:12:05 +0100
In-Reply-To: <3AB10B99.B5C43C07@mvista.com>
Message-ID: <yx2zoellh1m.fsf@aste15.ida.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> bk pull
> bk -r get
> edit your Makefile to run the proper tools and use the correct arch.
> make mcpn765_config
> make config (or whatever)
> make dep clean zImage
> you kernel will be in arch/ppc/boot/images/zImage.pp3

And it works! Thanks!

       /Björn Wingman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
