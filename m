Subject: Re: IDMA: Setting Up Parameter RAM.
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 26 May 2000 12:12:49 +1000 (EST)
In-Reply-To: <20000525060239.3F99C3C989@elph.research.canon.com.au> from "Greg Johnson" at May 25, 2000 04:02:39 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000526021249.D0E5F3C980@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Found the source of my IDMA troubles, programmer error. I was inadvertently
clearing the CPM command register between setting up the IDMA INIT command
and setting the FLG bit.

Sorry to have bothered all. Thanks to those who replied.

Regards

Greg.

--
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
