Return-Path: <n_tbinh@yahoo.com>
Received: from web30701.mail.mud.yahoo.com (web30701.mail.mud.yahoo.com
	[68.142.200.134]) by ozlabs.org (Postfix) with SMTP id E4683687D5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Nov 2005 20:52:59 +1100 (EST)
Message-ID: <20051123095257.69985.qmail@web30701.mail.mud.yahoo.com>
Date: Wed, 23 Nov 2005 09:52:57 +0000 (GMT)
From: Nguyen Thanh Binh <n_tbinh@yahoo.com>
To: Jaap de Jong <jaap.dejong@nedap.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <6915D0AE8B9047438F320B466AE30FDD152556@nvs0003.nedap.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Hi Jaap,

Thank you for replying.
I am still stuck on that.

Best regards,

Binh Nguyen


--- Jaap de Jong <jaap.dejong@nedap.com> wrote:

> Hi Binh,
> 
> I am working with this fpga too, different board,
> same linux version,
> and not very succesfull until now too...
> But my build passes the "Calibrating delay loop..."
> and prints the
> correct value!
> Just guessing... perhaps your problem is timer
> related. Fi no timer
> interrupts?
> 
> Best regards!
> 
> 	Jaap de Jong
> 
> 
> 
> > Hi all,
> > 
> > When booting Monta Vista Linux on Memec board
> > (Virtex-4 FX12 LC), it hung after printing the
> > following message:
> > 
> >     "Calibrating delay loop..."
> >
> > By looking at the source code, I found that in the
> > init/main.c the problem came from the
> > calibrate_delay()
> > function: jiffies was not incremented (jiffies was
> > always equal to 0).
> >
> > Have anyone get the similar problem or any
> experience
> > to fix it?
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
___________________________________________________________ 
Yahoo! Model Search 2005 - Find the next catwalk superstars - http://uk.news.yahoo.com/hot/model-search/
