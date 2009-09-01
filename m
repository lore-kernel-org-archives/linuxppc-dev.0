Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67])
	by bilbo.ozlabs.org (Postfix) with SMTP id C59CFB7B8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 12:31:15 +1000 (EST)
Date: Mon, 31 Aug 2009 22:31:11 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Gamsa <ben@somanetworks.com>
Subject: Re: time jumps forward/backwards
Message-ID: <20090831223111.7b2dc95d@lappy.seanm.ca>
In-Reply-To: <4A9C84D0.8040200@somanetworks.com>
References: <4A9C465D.4010801@somanetworks.com>
	<19100.24755.889091.412993@cargo.ozlabs.ibm.com>
	<4A9C6446.2000202@somanetworks.com>
	<4A9C664D.6010504@somanetworks.com>
	<4A9C84D0.8040200@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 31 Aug 2009 22:20:00 -0400
Benjamin Gamsa <ben@somanetworks.com> wrote:

> For what it's worth, the problem occurs even when ntp is not even
> started.

This is grasping, but could it have anything to do with the jiffies
wrapping near startup?

Cheers,
  Sean
