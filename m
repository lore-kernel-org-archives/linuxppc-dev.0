Return-Path: <netstv@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id 230FCDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 03:06:41 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so2106295wxd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 08:06:40 -0800 (PST)
Message-ID: <b4b98b690702200806u509badbbh3a1db5d1a5649b7@mail.gmail.com>
Date: Tue, 20 Feb 2007 08:06:39 -0800
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: 8541E and vector table.
In-Reply-To: <4DD2C4C8-908E-415C-A46F-8387E463D622@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <b4b98b690702200620q3c70cba9j2d8046d4451686a1@mail.gmail.com>
	<002d01c754fd$1f030860$0600000a@waves.com>
	<b4b98b690702200729g389fb77fr488ce2404566ace0@mail.gmail.com>
	<4DD2C4C8-908E-415C-A46F-8387E463D622@kernel.crashing.org>
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

On 2/20/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Feb 20, 2007, at 9:29 AM, Steve Iribarne (GMail) wrote:
>
> > Hi Ami,
> >
> > Thanks for the reply.  Yes I have the manual.  I guess I need to be a
> > little more specific.  I usually don't get down to this level of the
> > hardware.  It usually just works for me.
> >
> > I have all the explinations etc.. of each vector, but in my memory, I
> > can't figure out how to map 0x0000_0700 to one of the SPR's.  I think
> > that's what I want to know. :)
> >
> > -stv
>
> 0x700 is most likely Program Check Exception, there isn't a great way
> to do the reverse mapping (addr -> exception) other than looking at
> the code.  You can dump all the IVORs and see which matches if you want.
>

AHH!  That worked.  Thanks soo much.  And you were correct.  It was
the Program Check..

>


-- 
/*
 * Steve Iribarne
 * Software Engineer
 * (aka Grunt)
 */
