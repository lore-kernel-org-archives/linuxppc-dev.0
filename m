Return-Path: <dwm@austin.ibm.com>
To: Paul Nasrat <pnasrat@redhat.com>,
	Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: ipv6 in yaboot
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2007 14:21:21 -0500
Message-ID: <31368.1185909681@falcon10.austin.ibm.com>
From: Doug Maxey <dwm@austin.ibm.com>
Cc: yaboot-devel@ozlabs.org, Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Howdy!

I just got asked about ipv6 support in yaboot and a quick investigation
showed _no_ knowledge of the address formats in the code.

Should I be submitting an RFC for a full parser that can pick that 
apart?  Or does has someone have code lurking in the shadows, that 
just needed some prompting?  :)

++doug
