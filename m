To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Nov 2003 19:15:46 GMT."
             <DEF39A0710293E489D45B10E06645CBD026719AB@dub-msx1.spectelcorp.com>
Date: Wed, 12 Nov 2003 20:45:49 +0100
Message-Id: <20031112194554.7EE13C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD026719AB@dub-msx1.spectelcorp.com> you wrote:
>
> The SDRAM parameters used for initialisation have been fully verified

Parameters is one thing, the init sequence is  another  story.  Boith
are  required,  or you will see strange crashes as soon as the system
starts using burst mode heavily.

> with this board, as we have used them with another RTOS, without any
> problem.

That does not mean anything. Really. We have seen boards that used to
run pSOS+ for years without problem, but would crash  reliably  under
Linux. The problems went away after fixing the RAM initialization.

Your problem is a FAQ on the PPCboot / U-Boot mailing lists.

> Aditionaly I ran the u-boot mtest utility on sections of the RAM to
> ensure the configuration was good.

Again, that doesn't mean anything, as this test performs simple  read
/ write cycles. It will not cause any accesses in burst mode.

> I believe that rules out bad SDRAM configuration.

I disagree. I've seen this too many times before.

> I thought that could give me an idea if inflate was writing outside the
> valid
> virtual address range.

I think you're on the wrong track. But I may be wrong, of course.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Just Say No."   - Nancy Reagan
"No."            - Ronald Reagan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
