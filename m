Return-Path: <paravpandit@yahoo.com>
Received: from web36606.mail.mud.yahoo.com (web36606.mail.mud.yahoo.com
	[209.191.85.23]) by ozlabs.org (Postfix) with SMTP id 1E2CF67B65
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jul 2006 22:07:14 +1000 (EST)
Message-ID: <20060724120712.15709.qmail@web36606.mail.mud.yahoo.com>
Date: Mon, 24 Jul 2006 05:07:12 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Re: stupid linker question.... to remove unused functions in the
	object file.
To: Wade Maxfield <wmaxfield@gmail.com>,
	"Steve Iribarne \(GMail\)" <netstv@gmail.com>
In-Reply-To: <45a1b53e0607211410y196d76b4j1f9dc5c32014bc7a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have few functions in a C file but those are not
called at present. Even though those function
definitions are part of the object file.
Those will be called later on.

What CFLAGS should I pass to remove unused functions?
I cannot enable -Ox at present to have any
unpredictable behaviour.

Regards,
Parav Pandit


--- Wade Maxfield <wmaxfield@gmail.com> wrote:

> gcc -Wa,-alhs -g main.c >main.cs
> 
>   will put interleaved code/assembly into main.cs
> file.
> 
> wade
> 
> 
> 
> On 7/21/06, Steve Iribarne (GMail)
> <netstv@gmail.com> wrote:
> >
> > I forgot the flag that generates a list file that
> has both assembly
> > and c mixed in.
> >
> > Anyone?
> >
> > Thanks...
> >
> > -stv
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> > _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
