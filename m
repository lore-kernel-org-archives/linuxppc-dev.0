Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 00F8FDE1ED
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 12:06:48 +1000 (EST)
Date: Sat, 12 Apr 2008 22:06:46 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH 1/5] Boot code
Message-ID: <20080412220646.3d8ee450@lappy.seanm.ca>
In-Reply-To: <1208047783.5869.35.camel@vader.jdub.homelinux.org>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412140140.6c75cee5@lappy.seanm.ca>
	<1208047783.5869.35.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 12 Apr 2008 19:49:43 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Sat, 2008-04-12 at 14:01 -0400, Sean MacLennan wrote:
> > Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> > 
> 
> This patch is word wrapped.

Yes, sorry about that. I have been trying out a new mail client and I
pasted the text wrong :( I caught it in the other patches though,
so they should be good.

> > +	char name[40];
> > +	u32 v[2];
> > +
> > +	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x",
> > from);
> 
> Unless I can't count (which could very well be the case), you have a
> buffer overflow here.  The fixed string is 37 characters, and the
> values you are passing in for "from" will extend the string past the
> 40 bytes you have allocated for "name".

No, you are right. Good catch. I will update that.

Cheers,
   Sean
