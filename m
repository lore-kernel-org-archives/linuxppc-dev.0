Return-Path: <n_tbinh@yahoo.com>
Received: from web30714.mail.mud.yahoo.com (web30714.mail.mud.yahoo.com
	[68.142.201.252]) by ozlabs.org (Postfix) with SMTP id 70D9A687DE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Dec 2005 13:20:38 +1100 (EST)
Message-ID: <20051203021356.45878.qmail@web30714.mail.mud.yahoo.com>
Date: Sat, 3 Dec 2005 02:13:56 +0000 (GMT)
From: Nguyen Thanh Binh <n_tbinh@yahoo.com>
To: "Autran, Guillaume" <gautran@mrv.com>
In-Reply-To: <19EE6EC66973A5408FBE4CB7772F6F0A2105B5@ltnmail.xyplex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "'linuxppc-embedded@ozlabs.org '" <linuxppc-embedded@ozlabs.org>
Subject: RE: Booting hangs after "Calibrating delay loop..."
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Guillaume,

Thanks for replying.

I have did that but I did not work. I am using Monta
Vista Linux (kernel 2.4).

Best Regards,

Binh


--- "Autran, Guillaume" <gautran@mrv.com> wrote:

> Hi Binh Nguyen,
> 
> m8xx_setup.c moved in the recent 2.6 kernels to the
> syslib directory. I am
> using the 2.6.14 and the external RTC works with the
> modification I gave
> you.
> 
> The only other thing different is the initialization
> of the stamp variable
> in time.c
> I added the line: 'stamp = get_native_tbl();' right
> before
> 'last_jiffy_stamp(0) = tb_last_stamp = stamp;'
> 
> That's all.
> Guillaume
> 


Nguy&#7877;n Thanh Bình


	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
