Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi [213.243.153.189])
 by lists.ozlabs.org (Postfix) with ESMTP id B88F01A012D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 04:29:34 +1000 (AEST)
Date: Sun, 10 May 2015 21:32:59 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: G5 Xserve rackmeter broken?
Message-ID: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

With 4.1-rc2 the rackmeter driver for G5 Xserve is giving bogus
led patterns. So far I have seen at least the following:

a) With static load the leds seems to be sane and report CPU
usage properly, but after few minutes they go completely OFF,
even if the CPU load remains high.

b) On a completely idle system, leds alter between all OFF and all ON
roughly once a second.

Unfortunately I cannot say which was the last kernel where this worked
properly... These servers were away from normal use for a while due
to PSU issues.

A.
