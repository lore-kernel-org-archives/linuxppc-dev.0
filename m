Subject: Re: get_pteptr mystery
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <15873.4495.363395.683328@argo.ozlabs.ibm.com>
References: <1040256384.30597.70.camel@granite.austin.ibm.com>
	<15873.4495.363395.683328@argo.ozlabs.ibm.com>
Date: 18 Dec 2002 18:41:19 -0600
Message-Id: <1040258479.29647.72.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2002-12-18 at 18:23, Paul Mackerras wrote:
> Hollis Blanchard writes:
>
> > I need to mark the first kernel code page writeable because I need to
> > write to 0xc00000fc. Can someone tell me why the following code fails?
> > get_pteptr returns 0.
>
> What platform, what tree? :)

Right, sorry. linuxppc_2_4_devel running on a 405LP (Beech board).

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
