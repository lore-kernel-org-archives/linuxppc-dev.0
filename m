Message-ID: <3BAF691B.9020207@mc.com>
Date: Mon, 24 Sep 2001 13:10:51 -0400
From: Mark Salisbury <mbs@mc.com>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linuxppc-dev@lists.linuxppc.org, dan@mvista.com,
	hobold@Informatik.Uni-Bremen.DE, nicoya@apia.dhs.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <200109211848.f8LImlT19616@saturn.cs.uml.edu> <p05100302b7d16386402f@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Timothy A. Seufert wrote:

> Assuming you've identified all the needed changes for PPC LE with a
> LE board (*), I humbly submit that Mark & co. should get to work
> making a patch if they really want this feature.  The only item which
> might touch very much code is #5 (anybody know how frequently such
> instructions are used?), and a strong argument can be made that those
> instructions should not be used by anybody given their clearly
> deprecated status.  The rest of it is small enough to be maintained
> outside the regular trees, so they will not lose big time if it gets
> refused for integration.


we'll see how it goes and let you know...


--
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------*/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
