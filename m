Date: Thu, 9 Sep 1999 16:30:58 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Hugh Caley <hcaley@loomer.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Paul's devel branch on Lombard?
Message-ID: <19990909163058.A22217@io.nu>
References: <37D74322.B787B9FE@loomer.com> <19990909092545.C4200@io.nu> <37D7C974.77E93281@loomer.com> <37D820B5.F84B223D@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37D820B5.F84B223D@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
> Kernel 2.3.16 is from cvs@openprojects, with 2 little patches to make it
> compile and to recognize my ethernet card. I'll reboot in a minute to
> try 2.3.17.

I tried 2.3.16 last week (from cvs from openprojects), and had similar
machine check problems on boot.  It _did_ seem to recognize all my
hardware (perhaps the BMAC did not work, but I couldn't tell, it wouldn't
stay up that long).  

If I use the CVS kernel, will I _need_ 2.95, or will EGCS 1.1.2 work?

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
