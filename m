From: Benjamin Herrenschmidt <bh40@calva.net>
To: <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI compatibility
Date: Thu, 20 Jul 2000 17:53:14 +0200
Message-Id: <20000720155314.9357@mailhost.mipsys.com>
In-Reply-To: <39771F7D.EC15EC8D@biophys.uni-duesseldorf.de>
References: <39771F7D.EC15EC8D@biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ani Joshi wrote:
>>
>> On Thu, 20 Jul 2000, Sacha Varma wrote:
>>
>> > So... does this mean that as far as hardware is concerned there is
>nothing to prevent me from using any old PCI graphics card in a (non-
>AGP?) mac so long as linux has drivers for it?
>>
>> Correct, there is nothing preventing any PCI graphics device from working
>> in linux unless there is something extremely fundamentally wrong with it
>> (like relying on PC BIOS too much, but that is very rare)
>
>Or Linux not finding the card because it didn't get an OF device tree
>node?

Normally, all PCI cards should get a node. Linux will use normal PCI
probing so it can find cards missing in OF, but in this case, I beleive
it won't be able to map the interrupt line.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
