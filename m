Date: Thu, 23 Mar 2000 13:28:59 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: shaolin zhang <zhangshaolin@sz.huawei.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org, eric_mariacher@fr.ibm.com,
        rtl@rtlinux.cs.nmu.edu
Subject: Re: problem of port rtlinux3.0 for mpc to 2.2.13 kernel
Message-ID: <20000323132859.V2133@medea.fsmlabs.com>
References: <006c01bf94cf$c87f72c0$c4190b0a@huawei.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <006c01bf94cf$c87f72c0$c4190b0a@huawei.com.cn>; from shaolin zhang on Thu, Mar 23, 2000 at 09:57:52PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You're going to have trouble porting rtlinux3.0 to a 2.2 kernel.  It was
designed around 2.3 and we haven't backported it to 2.2 yet.  If there's
enough interest we may do that, though.

Would you be willing to give 2.3.x a try?

}     these days I have do some working for port rtlinux3.0 for mpc860 to 2.2.13 kernel. I has modified the __cli __sti etc, and the kernle is runing ok in our embed 860 board. but when I insmod the rtl.o the kernel killed the process by SIGSEGV "pid 7: killed (signal 11)". I have traced the kernel ,and find when in function "do_page_fault" to call "find_vma", but no vma can finded.
}     anybody has good advie for this problem.
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
