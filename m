Date: Thu, 29 Nov 2001 09:30:46 +1100
From: Anton Blanchard <anton@samba.org>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_ALL_PPC
Message-ID: <20011129093046.B28534@krispykreme>
References: <15365.24592.409195.392505@gargle.gargle.HOWL> <20011128162046.L23942@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011128162046.L23942@altus.drgw.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I thought were were goign to call it 'CONFIG_WORKSTATION_PPC' or
> 'CONFIG_DESKTOP'
>
>
> I'd be happy with CONFIG_DESKTOP, or CONFIG_PPC_MULTIARCH.

Perhaps PPC32 instead PPC in the above examples, otherwise
DESKTOP/WORKSTATION etc could apply to PPC64 (it crept into the ppc64
tree by mistake at one point since CONFIG_ALL_PPC sounds like all PPC :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
