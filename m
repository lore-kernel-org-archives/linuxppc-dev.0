From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: iBook and Kernel 2.2.17pre7
Date: Mon, 26 Jun 2000 18:45:27 +0200
Message-Id: <20000626164527.9318@mailhost.mipsys.com>
In-Reply-To: <20000626124613.7321@mailhost.mipsys.com>
References: <20000626124613.7321@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 26, 2000, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>>- The atyfb driver now recognize my iBook ATI Mobility 3D Rage L
>>chipset. The only problem I have with it is that the initialisation
>>mode detection is bad and you have to issue a "vmode 10" to get it
>>working properly.
>
>Glad to know it works. I'll look into this init problem. Note that you
>may want to try increasing slightly the mclk value. It defaults to 50,
>but some users got it working well at 55. for some reason, the speed
>difference can be important.

BTW. Many thanks to 'Mike' Michal Palczewski who found what was wrong in
my code for the iBook !

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
