Date: 25 Sep 2002 14:13:51 -0000
Message-ID: <20020925141351.31835.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "Rajendra Prasad Mishra" <r_p_m@rediffmail.com>
Reply-To: "Rajendra Prasad Mishra" <r_p_m@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE disk size
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all !
     I am working on a board with a ibm 405GP processor and a
winbond W83C553 ide controller. I have been able to sucessfully
detect the disk and set irqs. The problem is that the ide driver
is not detecting the size of the disk properly it's showing 8.4 GB
instead of 20GB . Apart from that i am able to do all operations
on the disk i.e create a file system / write files to it etc. but
i am able ot use only 8.4 GB of the total disk space !
    Does anyone has any idea about why this is happening ? do i
have to do give some special  things if i want the ide driver to
work on powerpc ?

p.s : please cc me as i am not subscribed to the list

regards,
raj
__________________________________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
