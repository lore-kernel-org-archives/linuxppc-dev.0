Message-ID: <406C8104.9050609@acm.org>
Date: Thu, 01 Apr 2004 15:52:20 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net>
In-Reply-To: <20040401191715.GC3786@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eugene Surovegin wrote:
> On Thu, Apr 01, 2004 at 02:10:00PM -0500, John Whitney wrote:

> I think we should add such info to a structure which describes the _bus_, not
> _device_.
> I'm not "new-device-model" guru, so I cannot comment _how_ this can be
> implemented though :)

A bus description alone is not sufficient. A generic DMA API should take
both a source and destination device. Between any two sources and
destinations there may be several intervening bridges, which potentially
means programming those bridges and/or doing several address translations.

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
