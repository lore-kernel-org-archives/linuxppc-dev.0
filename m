Message-ID: <3C1902F0.9040807@embeddededge.com>
Date: Thu, 13 Dec 2001 14:35:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@labs.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled - problem found
References: <3C112297.6DE37608@labs.mot.com> <3C114C63.3050102@embeddededge.com> <3C14F91F.F382ABE3@labs.mot.com> <3C177748.1A1342C2@labs.mot.com> <3C17E3B4.9E73B22E@labs.mot.com> <3C18336D.7030706@embeddededge.com> <3C18C309.9D234D7F@labs.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:


> Thanks for your followup Dan. I've got a rather straightforward "dumb" approach
> to fixing this problem - see the patch below.

Looks pretty good.  My last concern is the way we overload the semantics of
the functions depending upon a driver requesting the service and the interrupt
controller using these functions.  For example, a driver will request to
enable or disable one particular interrupt, while the interrupt handling functions
will need to honor the priority, as you have added.  Allowing a driver request
to affect the priority mask may not be appropriate.

Thanks for the effort understanding the problem and finding a solution that
works for you.  It appears to be "more right" than it was :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
