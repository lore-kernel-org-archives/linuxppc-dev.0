From: Benjamin Herrenschmidt <bh40@calva.net>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
Date: Tue, 25 Jul 2000 15:20:28 +0200
Message-Id: <20000725132028.17969@mailhost.mipsys.com>
In-Reply-To: <397D6A7A.CBF58A52@francetelecom.fr>
References: <397D6A7A.CBF58A52@francetelecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Just a question about RTAS on PowerMac G4,
>does linux kernel can call RTAS function ?
>And if not, why ?
>I'm trying to do it and that fail...

RTAS in not correctly implemented in those machines. Apple is apparently
abandonning it, the implementation in ROM for all core99 machines is
bogus. What do you want to use RTAS for ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
