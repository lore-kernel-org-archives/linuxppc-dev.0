Subject: RE: PCI daughter card with USB on a 405GP
From: Xavier Miville <xmiville@oerlikon.ca>
To: v.sudeep@exgate.tek.com
Cc: samsongshzu@yahoo.com.cn, wd@denx.de,
	mporter@kernel.crashing.org, laurent.mohin@acterna.com,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <AE20493C16DE7F46BC29B257C8D708D30130405C@mail.oerlikon.ca>
References: <AE20493C16DE7F46BC29B257C8D708D30130405C@mail.oerlikon.ca>
Content-Type: text/plain
Message-Id: <1077812871.1585.26.camel@PC856-DDUVAL.oerlikon.ca>
Mime-Version: 1.0
Date: 26 Feb 2004 11:27:51 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You will need to apply the corresponding linuxppc patch
(/pub/linux/kernel/ports/ppc/2.4) to 2.4.22. The zvmlinux doesn't seem
to be built with only 2.4.22.

Hope this helps.

On Thu, 2004-02-26 at 09:05, v.sudeep@exgate.tek.com wrote:
> 3. I downloaded and built the tool chain for the 405GP. And am running
> into
> problems trying to compile the linux 2.4.22 kernel. I am not sure of
> what I
> must do to create the treeboot image... I think by default it does not
> do
> it.. it creates only the vmlinux.gz
>

--
Xavier Miville
Junior Firmware Engineer
Engineering Department
Oerlikon Contraves Inc.

Tel: (450) 542-5683
Fax: (450) 358-7708
xmiville@oerlikon.ca


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
