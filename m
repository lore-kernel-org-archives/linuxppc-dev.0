From: pnilesh@in.ibm.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <CA256A0D.004BE24A.00@d73mta05.au.ibm.com>
Date: Mon, 12 Mar 2001 19:09:18 +0530
Subject: wrong msr/nip value
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
                I am using Apple G4 dual on which I am getting ZERO values
of msr,nip and other
register values of strcut ptr_regs in the signal handler.

                                         My code is like this,
void handler(int signum,siginfo_t *s_,void *v)
{
                      struct sigcontext *p = (struct ptr_regs *)v;
printf("msr = %x \n nip = %x \n", p->regs->msr,p->regs->nip);
}

You can assume to it be an SIGALRM handler .

Thanks
Nilesh


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
