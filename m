From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: insmod trouble
Date: Thu, 27 May 2004 09:15:58 +0200
References: <20040525095554.A5EC4C109F@atlas.denx.de>
In-Reply-To: <20040525095554.A5EC4C109F@atlas.denx.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405270915.58686.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

my problem was ...
> > --------------------------------------------------
> > bash-2.05b# insmod demodriver.o
> > demodriver.o: unresolved symbol module_unregister_chrdev
> > demodriver.o: unresolved symbol register_chrdev
> > demodriver.o: unresolved symbol led_init
> > demodriver.o: unresolved symbol printk
> > ------------------------------------------------
> >
> > What is the reason for this messages ??

Solution: You have to disable "Set version information on all module symbols" under "Loadable module support" in our kernel config.

Thanx for comments
Marco


---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
