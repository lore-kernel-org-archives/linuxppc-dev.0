Message-ID: <3D082846.4080005@embeddededge.com>
Date: Thu, 13 Jun 2002 01:06:14 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_alloc from an interrupt context
References: <5.1.0.14.2.20020612200144.00ab2398@mail.zultys.com> <5.1.0.14.2.20020612211908.02c7b0e8@mail.attbi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

> I thought of it, but is it OK to modify arch-independent code with such
> a hack?

It's OK in your own code, I probably still have some around that looks
like that :-)

> Maybe this is the reason it never was accepted.

I'll have to search for the messages where this was discussed and see what
happened.  I know it wasn't discussed on the PowerPC lists, it was on some
other processor I was using.  I was just able to make the same changes and
test it on 8xx as well.

> Though, it's obviously much simpler than solution I used :)

Hey, whatever works......it's a hacker's world :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
