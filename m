From: Benjamin Herrenschmidt <bh40@calva.net>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
Date: Wed, 12 Jul 2000 13:40:49 +0200
Message-Id: <20000712114049.26089@mailhost.mipsys.com>
In-Reply-To: <Pine.SOL.3.95.1000712132311.21439E-100000@juliet>
References: <Pine.SOL.3.95.1000712132311.21439E-100000@juliet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Yes, Lombard 333 MHz standard configuration.
>
>I did compile dmasound as module (I noticed that after applyiing your patch,
>dmasound was unselected in .config - is there a reason for this?).
>I will test this, though I'm not sure if it's easy to reproduce -
>if it takes a prolonged time of sleep for the effect to come up...

Did you experience this problem at all with previous kernel ? I'm
wondering if it would be good to leave the powerbook a bit more time when
coming out of sleep before turning back on the various parts.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
