Message-ID: <3E9F669B.7A2B1C72@cs.fujitsu.co.jp>
Date: Fri, 18 Apr 2003 11:44:43 +0900
From: Takeharu KATO <tkato@cs.fujitsu.co.jp>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Task tsruct relevant question
References: <3E9F440A.52FE7459@cs.fujitsu.co.jp> <16031.22226.295030.685058@nanango.paulus.ozlabs.org>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Takeharu KATO writes:
>
> > I have a queestion about task_struct relevant issue.
> > As far as I know, task_structs in kernel 2.5.X are placed in
> > slab cache. But they are placed on kernel stack on linux-2.4.67
> > for PPC4xx.
Sorry.　I made typo.
I wanted to say task_struct is not separated from kernel stack
in linux-2.5.67  for PPC4xx support.
Does anyone have plan to separate task_struct from kernel stacks
for PPC4xx port?


--
Takeharu KATO
Fujitsu Limited
Email:tkato@cs.fujitsu.co.jp (ext. 7112-4621)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
