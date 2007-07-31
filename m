Return-Path: <pnasrat@redhat.com>
Subject: Re: ipv6 in yaboot
From: Paul Nasrat <pnasrat@redhat.com>
To: Doug Maxey <dwm@austin.ibm.com>
In-Reply-To: <31368.1185909681@falcon10.austin.ibm.com>
References: <31368.1185909681@falcon10.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 21:11:01 +0100
Message-Id: <1185912661.9310.143.camel@enki.eridu>
Mime-Version: 1.0
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>, yaboot-devel@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-31 at 14:21 -0500, Doug Maxey wrote:
> Howdy!
> 
> I just got asked about ipv6 support in yaboot and a quick investigation
> showed _no_ knowledge of the address formats in the code.

We really just use OF for obp-tftp and don't have our own ip stack, as
there is no 1275 standard for ipv6 (although some modern IBM firmwares
which also have iscsi support it) it's somewhat hard.

> Should I be submitting an RFC for a full parser that can pick that 
> apart?  Or does has someone have code lurking in the shadows, that 
> just needed some prompting?  :)

Have you tried it with firmware that supports obp-tftp over ipv6?

Paul
