Return-Path: <annamaya@yahoo.com>
Received: from web53809.mail.yahoo.com (web53809.mail.yahoo.com
	[206.190.36.204]) by ozlabs.org (Postfix) with SMTP id 0F43767A7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 06:40:09 +1100 (EST)
Message-ID: <20050125194008.68818.qmail@web53809.mail.yahoo.com>
Date: Tue, 25 Jan 2005 11:40:07 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050125191047.GA3818@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Additional data/instruction BATs not initialized for MPC8280?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Doh! So that's how we get away with it.

--- Eugene Surovegin <ebs@ebshome.net> wrote:

> On Tue, Jan 25, 2005 at 09:49:13AM -0800, annamaya
> wrote:
> > I have read in the specs for the MPC8280 that it
> has a
> > G2_LE core which has 4 additional data and
> instruction
> > BATs. However, I dont see these BATS being cleared
> > early in the kernel. I only see that the first 4
> pairs
> > are cleared using the mtspr instructions. But my
> > kernel comes up just fine and everything seems to
> work
> > OK. Dont we need to clear the other set of
> I/DBATS?
> > What happens when we dont do this? Thanks in
> advance.
> 
> Additional BATs in G2_LE core must be explicitly
> enabled in HID2 (HBE 
> bit), until then they "don't exist" :).
> 
> --
> Eugene
> 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
