Message-ID: <3D3F8EC9.7070105@dslextreme.com>
Date: Wed, 24 Jul 2002 22:38:17 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Matthew Locke <mlocke@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
References: <3D3E4145.8030500@dslextreme.com> <3D3F04F7.1020005@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matthew Locke wrote:
>
>
> Rather than replace the whole idle loop, I would allow for
> sub-arch/processor specific code in the idle loop.  Perhaps move the
> power_save routine into the platform code?
>

This sounds like a good idea if we could use
  if( ppc_md.powersave != NULL)
       ppc_md.powersave();

If it is determined that calling power_save() which is resides in an
arch/processor specific file then we are talking about many files being
hit.  and the current power_save seems to common for many other ppc
platforms other than 4xx & 8xx

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
