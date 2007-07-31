Return-Path: <dwm@austin.ibm.com>
In-reply-to: <1185912661.9310.143.camel@enki.eridu> 
References: <31368.1185909681@falcon10.austin.ibm.com>
	<1185912661.9310.143.camel@enki.eridu>
To: Paul Nasrat <pnasrat@redhat.com>
Subject: Re: ipv6 in yaboot 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2007 16:08:49 -0500
Message-ID: <32757.1185916129@falcon10.austin.ibm.com>
From: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>, yaboot-devel@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 31 Jul 2007 21:11:01 BST, Paul Nasrat wrote:
>On Tue, 2007-07-31 at 14:21 -0500, Doug Maxey wrote:
>> Howdy!
>> 
>> I just got asked about ipv6 support in yaboot and a quick investigation
>> showed _no_ knowledge of the address formats in the code.
>
>We really just use OF for obp-tftp and don't have our own ip stack, 

True.  Was just curious about the handling of the address formats, 
where the xxxx:... will probably be used.  Several spots already make 
lots of assumptions that the colons are only in the disklabel.

> as
>there is no 1275 standard for ipv6 (although some modern IBM firmwares
>which also have iscsi support it) it's somewhat hard.

Oh, I agree completely.  Publication is still being worked.  The good 
news is that the description is already there.  Once folks can see the 
whole enchilada.

>
>> Should I be submitting an RFC for a full parser that can pick that 
>> apart?  Or does has someone have code lurking in the shadows, that 
>> just needed some prompting?  :)
>
>Have you tried it with firmware that supports obp-tftp over ipv6?

Heh.  Not yet, but RSN.
