From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH: final version of l2cr cmd line
Date: Sun, 3 Sep 2000 15:45:50 +0200
Message-Id: <20000903134550.27884@192.168.1.10>
In-Reply-To: <200009031315.PAA00925@piglet.grunz.lu>
References: <200009031315.PAA00925@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Since BenH fixed the _set_L2CR() function, I have been able to shorten
>the l2cr command line code. Attached is the patch vs. your current 2.4
>rsync tree. I've not been able for a long time to boot a 2.4 kernel, but
>it never crashed in this part ;-)

PS: Thanks again to PowerLogix (and their PPC guru, Terry Greeniaus) who
provided the _set_L2CR() code, which, as you can see, can be quite tricky.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
