Subject: Re: __cli on 4xx - MSR:CE?
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020731005244.GA27711@zax>
References: <1028054814.13540.131.camel@granite.austin.ibm.com>
	<3D46E96B.1020504@dslextreme.com>  <20020731005244.GA27711@zax>
Content-Type: text/plain
Date: 31 Jul 2002 10:49:02 -0500
Message-Id: <1028130543.13540.168.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-07-30 at 19:52, David Gibson wrote:
>
> If critical interrupts are disabled everywhere that normal interrupts
> are disabled, there seems little point in having them.

Sure, I understand that. Will there then be a "__crit_cli" for when you
really don't want exceptions of any kind? And __save_and_crit_cli ?

-Hollis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
