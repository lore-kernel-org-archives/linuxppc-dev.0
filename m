Subject: Re: ELDK & MPC8272ADS. Machine check
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Bastos Fernandez Alexandre <ALEBAS@televes.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040702101005.8790FC109F@atlas.denx.de>
References: <20040702101005.8790FC109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1088764790.14216.4230.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 02 Jul 2004 11:39:50 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-07-02 at 12:10 +0200, Wolfgang Denk wrote:
> You will need a version of  the  Linux  kernel  tree  which  includes
> support  for  the MPC8272ADS board. The kernel tree inlucded with the
> ELDK does not contain such support. You will probably be able to  use
> the "ads8260" configuration to some extend, though.

The 2.6.7 kernel got support for the MPC8272ADS quite recently.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
