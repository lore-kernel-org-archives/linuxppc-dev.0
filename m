Message-ID: <406C9A3C.4010108@acm.org>
Date: Thu, 01 Apr 2004 17:39:56 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net>
In-Reply-To: <20040401220018.GA4130@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eugene Surovegin wrote:
> On Thu, Apr 01, 2004 at 03:52:20PM -0500, Michael R. Zucca wrote:
?
> In case of several bridges, I think it's simpler just to assign _different_
> buses for each bus connected by a bridge.

Ok, I see. So if you assume the CPU is a target/source, you can infer
any intervening bridges/busses. I assume the bridge/bus hierarchy is
stored somewhere so you can do the appropriate programming/translation
for each bridge.

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
