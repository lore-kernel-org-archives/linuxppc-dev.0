Return-Path: <mikey@ozlabs.org>
To: jschopp <jschopp@austin.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: whitespace cleanup in reg.h 
In-reply-to: <4460E0BC.4050908@austin.ibm.com> 
References: <20060509163419.E4E1767A04@ozlabs.org>
	<4460E0BC.4050908@austin.ibm.com>
Date: Tue, 09 May 2006 14:01:05 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060509190145.D360567A79@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But then you seem to be trying to do indenting with 3 spaces instead of tabs.

I disagree.  These used to be #define<tab><space><space>.  I just
changed them to #define<space><space><space>.

> And your values don't line up, and your comments don't line up.

Try applying the patch and looking at reg.h.  It looks much different
there than in the patch.  

> I'm just saying, either fix the formatting right or don't fix it at
> all.  Moving it from one ugly to another ugly is not worth the trouble.

With 8 character tabs, I've not changed to look at all.  

Mikey
