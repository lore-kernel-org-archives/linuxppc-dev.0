Return-Path: <kallepokki@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.203])
	by ozlabs.org (Postfix) with ESMTP id E2D9F67D42
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 18:41:13 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id v1so133051nzb
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 23:41:11 -0800 (PST)
Message-ID: <a425f86c0611132341h7d534ee8m6874e64c9e8cb336@mail.gmail.com>
Date: Tue, 14 Nov 2006 09:41:10 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "tran vanle" <vantranbk@yahoo.com.au>
Subject: Re: telnet error
In-Reply-To: <20061113143248.31649.qmail@web33001.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061113143248.31649.qmail@web33001.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/13/06, tran vanle <vantranbk@yahoo.com.au> wrote:
> Hi all
> I use kernel 2.6.11.7 and Ramdisk in ELDK 4.0 (I just use ,not rebuild
> Ramdisk). But when I telnet to this board ,i receive
>
> telnetd: All network ports in use!

I vaguely remember trying the same thing with a MPC860 target and
having the same error messages. If I remember it right, the message
was caused by missing PAM libraries or something like that. I can't
give you any specific instructions, but you might want to google for
PAM and telnet to get some more directions.
