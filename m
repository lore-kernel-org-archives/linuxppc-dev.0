Return-Path: <emrekara2002@yahoo.co.uk>
Received: from web25701.mail.ukl.yahoo.com (web25701.mail.ukl.yahoo.com
	[217.12.10.173]) by ozlabs.org (Postfix) with SMTP id 57D5667A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 21:25:32 +1100 (EST)
Message-ID: <20050318102530.84315.qmail@web25701.mail.ukl.yahoo.com>
Date: Fri, 18 Mar 2005 10:25:29 +0000 (GMT)
From: emre kara <emrekara2002@yahoo.co.uk>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 440GX kernel 2.6 NAPI driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have patched emac_3-2.6-9.diff against kernel 2.6.11
release version and fixed the rejections, but the
problem that I faced is not only from the .rej files,I
have succeeded to compile the kernel and load the
target, but it take long time to boot and there was
some errors printed on the console, I think the patch
corrupted some other files
And also tested ethernet performance with the patched
kernel, it was not as good as 2.4 version, especialy
there was a huge performance decrease on the receive
side.
Second (big) problem is, I dont know how to log on to
BK tree :) 
Maybe I can patch emac_3-2.6-8.diff against kernel
2.6.11, but I dont have this file(It is not on your
web site at the present.), where can I download it?
Thanks alot.
Emre


--- Eugene Surovegin <ebs@ebshome.net> wrote:
> On Fri, Mar 18, 2005 at 09:41:43AM +0000, emre kara
> wrote:
> > but I can't patch the file for
> > kernel 2.6.11 (emac_3-2.6-9.diff)(on kernel.org).
> > Some .rej files created by patch.(ie mii.rej).
> Which
> > kernel source must I use as base?
> 
> emac_3-2.6-9.diff is against 2.6 BK tree as of
> 2005-03-07 11:01pm PST.
> I'll try to find some time this weekend and re-diff
> (if needed) 
> against latest BK, in the meantime, try resolving
> those rejects - 
> mii.rej shouldn't be very difficult.
> 
> If you applying patch to the 2.6.11 _release_ (not
> current BK tree), 
> try emac_3-2.6-8.diff.
> 
> --
> Eugene
> 

Send instant messages to your online friends http://uk.messenger.yahoo.com 
