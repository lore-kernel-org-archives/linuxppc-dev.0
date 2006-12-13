Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53109.mail.yahoo.com (web53109.mail.yahoo.com
	[206.190.49.59]) by ozlabs.org (Postfix) with SMTP id 413CE67CC3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 03:20:57 +1100 (EST)
Date: Wed, 13 Dec 2006 08:20:54 -0800 (PST)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: Re: Floating Point Operation in Kernel
To: Carlos Munoz <carlos@kenati.com>
In-Reply-To: <457F5B36.3000303@kenati.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <46717.30845.qm@web53109.mail.yahoo.com>
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

We has a hardware driver need the floating point
operation to do timing recover. Maybe, we have to do
it in user space.

--- Carlos Munoz <carlos@kenati.com> wrote:

> jimmy liu wrote:
> 
> >I am writing a module which need be integrated to
> the
> >linux kernel with floating point operations for
> >mpc82xx. The kernel does not provide support for
> >floating point operations. Does anybody have good
> idea
> >to implement it or make it to work around?
> >
> >
> >
> > 
>
>____________________________________________________________________________________
> >Yahoo! Music Unlimited
> >Access over 1 million songs.
> >http://music.yahoo.com/unlimited
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
>
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >  
> >
> What exactly is the floating point operation you
> need to implement ?
> 
> 
> Carlos
> 
> -- 
> There are two rules for success in life:
> 1) Never tell everything you know.
> 
> 



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
