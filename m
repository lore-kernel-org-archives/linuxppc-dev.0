Message-ID: <387EDEF5.DBD612FA@huawei.com.cn>
Date: Fri, 14 Jan 2000 16:31:49 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile Applications for 860 on x86
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn> <386ADE53.D3411F6A@ctam.com.au> <38704D0B.94438516@huawei.com.cn> <386AFFC5.E0134DB8@ctam.com.au> <38708C86.2CD58E66@huawei.com.cn> <387142DF.7A3025D0@ctam.com.au> <38715DAE.B6CBC772@huawei.com.cn> <3871572F.FA4E7842@ctam.com.au> <38717C52.ECF1AFFD@huawei.com.cn> <3871953B.345DDA23@ctam.com.au> <38754F28.B6B4CE70@huawei.com.cn> <38754419.20D95C5A@ctam.com.au> <3876A6E5.3488738B@huawei.com.cn> <3876C6FD.794BD1BF@ctam.com.au> <387A87DF.4ED23CA6@huawei.com.cn> <387A81F3.702B29A2@ctam.com.au> <387C4D8D.9C058F1C@huawei.com.cn> <387D3212.A4E9904F@ctam.com.au> <387DAFAF.DB0096C7@huawei.com.cn> <387E460F.B007CE56@ctam.com.au> <387E7F82.99AF83CE@huawei.com.cn> <387E7AF5.A92A6122@ctam.com.au> <387E9927.48689C08@huawei.com.cn> <387EBEB9.B69B1680@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
     When I compile the SASH  with "-static" options and then replace /bin/sh with sash.
When reseting my MPC860 based board, the kernel boot normally and can show the boot messages. But at last it
cannot show the "bash#" prompt. If I input "ls" or such commands,
It justs shows :

    ls
    pid 8: killed (signal 11)
    ls
    pid 9: killed (signal 11)
    ls
    pid 10: killed (signal 11)

Do you know why? What do I miss?
Thanks very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
