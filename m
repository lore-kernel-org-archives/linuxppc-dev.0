Return-Path: <arsadri@yahoo.ca>
Message-ID: <20050126130039.68067.qmail@web30707.mail.mud.yahoo.com>
Date: Wed, 26 Jan 2005 05:00:39 -0800 (PST)
From: Alireza Sadri <arsadri@yahoo.ca>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: target board NFS mounting timeout
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi , 

I have a problem with mounting NFS by an external
board on my host.

kernel doesn't mount NFS for the first time it boots
(or sometimes for second time ) but when i reset the
board another time , it can find the server , i must
add that if the time between two tryings gets too much
, it will fail to mount it even for the second time i
reset. 

I used ethereal (watched the packets of Ethernet) and 
saw that server sends status of last packet OK for
mounting NFS , but the client didn't mount it . I
think it is because , the timeout of client (kernel)
is not enough. or maybe the problem is due to my
server's settings.

has anyone faced similar problem , or can anyone help
me please?

i use a 82xx and ELDKv3 kernel v2.4.24 as target , and
a SuSE9.1 as my host . i have stablished my NFS server
using YAST2.

Best regards,
Alireza Sadri.


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
