Message-Id: <s854c067.089@a-hgwd3.harwell.aeat.co.uk>
Date: Mon, 13 Dec 1999 09:45:55 +0000
From: "Frank Smith" <frank.smith@aeat.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Forgive me if I am reminding you of things you already know.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Forgive me if I am reminding you of things you already know.

Do not expect to get anything like the maximum through Ethernet unless you only have two connections.  
Collisions etc. kill bandwidth........  We manage 0.5 M Byte in a "deterministic" way on 
MVME176 - MVME2600 combination but any more seems like suicide.

Frank

>Marcus Sundberg writes:
>> No, Graham was expecting/hoping for 8 M _bytes_, not bits.
>> So in fact it's actual performance is about 1/3 of that, which
>> I pointed out to him.
>
>Marcus is right; we'd like to use all the bandwidth available on the FEC for
>optimal system performance. Can anyone elaborate or provide pointers to more
>information on the FEC throughput issue? Is there really a hardware problem in
>the CPU, or is it a board specific issue?
>
>Thanks,
>Graham



***********************************************************************
This transmission contains information which may be confidential and  
which may also be privileged.  It is intended for the named addressee  
only.  Unless you are the named addressee, or authorised to receive it 
on behalf of the addressee you may not copy or use it, or disclose it 
to anyone else.  If you have received this transmission in error please 
contact the sender.  Thank you for your cooperation. 
***********************************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
