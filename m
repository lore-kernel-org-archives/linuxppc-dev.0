From: linas@austin.ibm.com
Date: Fri, 23 May 2003 11:26:10 -0500
To: Trevor Woerner <ppc339@vtnet.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide interrupts
Message-ID: <20030523112609.A39578@forte.austin.ibm.com>
References: <200305231136.51119.ppc339@vtnet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305231136.51119.ppc339@vtnet.ca>; from ppc339@vtnet.ca on Fri, May 23, 2003 at 11:36:51AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 23, 2003 at 11:36:51AM -0400, Trevor Woerner wrote:
>
> There seems to be a lot of code in the IDE subsystem relating to
> interrupts. Is there a way to set a device in polled (i.e.
> non-interrupt) mode? Maybe some way to run the tasklet/bh periodically?

Why?

> Does the IDE system want to monitor my ATA device's Ready_NotBusy
> interrupt?

Why?

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
