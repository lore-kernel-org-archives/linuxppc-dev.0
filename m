Message-ID: <20020219092656.26237.qmail@web9705.mail.yahoo.com>
Date: Tue, 19 Feb 2002 01:26:56 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: USB in RPXLITE 823
To: Dan Malek <dan@embeddededge.com>
Cc: Sarnath Kannan <sparc64@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3C712B65.3040305@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Yes, 8260 doesn't have USB controller.
I had that message when I tried to configure
port C for the ATM. (config utopia pins).
I had the same problem. Ethernet stopped at the
same point. When I configured pins via ppcboot,
everything went ok..Strange..but...thats how I
solved the problem...
                     D. Meidanis

--- Dan Malek <dan@embeddededge.com> wrote:
> None Atall wrote:
>
> >  Well, I have come to that message too, but for
> 8260.
>
> The last time I check, nothing in the 8260 family
> had
> an integrated USB controller...........
>
>
> 	-- Dan
>


=====
-------------------------------------------------
  Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
  Greece.
-------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
