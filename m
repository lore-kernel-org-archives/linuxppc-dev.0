Message-Id: <200210020156.AA00446@cj3020122-a.isd.mci.mei.co.jp>
From: yamazaki <yama@isd.mci.mei.co.jp>
Date: Wed, 02 Oct 2002 10:56:23 +0900
To: Michael Habermann <mhabermann@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: nfsmount
In-Reply-To: <3D9A4F24.9070005@gmx.de>
References: <3D9A4F24.9070005@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for reply.

I start the NFS Server with /etc/init.d/nfs start on nfs server.
And,other client can nfsmount on nfs server.

I know it can nsmount without rpc.statd,but take a long long time.

>yamazaki wrote:
>
>> Hello,
>>
>> I have a question.
>> We made a custom board(mpc8245 used),and implemeted kernel-2.2.18.
sorry it was wrong.kernel is 2.4.18.
>> It works very well.
>> now,I tried to implement nfsmount client in single user mode.
>> Is does not work.
>> Then I knew the reason which is for rpc.statd missing.
>> I could not found rpc.statd form the message of ps -aux.
>>
>> Please tell me if you know why it does not work.
>>
>> ----
>> yamazaki  yama@isd.mci.mei.co.jp
>>
>>
>>
>>
>
>You need to start the NFS Server with /etc/init.d/nfs start.
>

----
yamazaki  yama@isd.mci.mei.co.jp


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
