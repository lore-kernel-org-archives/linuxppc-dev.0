Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18095.56272.4647.158912@cargo.ozlabs.ibm.com>
Date: Wed, 1 Aug 2007 11:03:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: ipv6 in yaboot
In-Reply-To: <31368.1185909681@falcon10.austin.ibm.com>
References: <31368.1185909681@falcon10.austin.ibm.com>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Paul Nasrat <pnasrat@redhat.com>, yaboot-devel@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Doug Maxey writes:

> I just got asked about ipv6 support in yaboot and a quick investigation
> showed _no_ knowledge of the address formats in the code.
> 
> Should I be submitting an RFC for a full parser that can pick that 
> apart?  Or does has someone have code lurking in the shadows, that 
> just needed some prompting?  :)

I would have thought that yaboot would just be passing any network
addresses in text form to some OF method, so it's up to OF to
understand ipv6 address formats.  No?

Paul.
