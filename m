Return-Path: <eemingliu@hotmail.com>
Message-ID: <BAY138-F25C6B0625737531B77D706B2E30@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: basic and stupid question on wait_event and wake_up
Date: Sun, 12 Aug 2007 13:57:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,
I am reading LDD(V3) chapter 6 on the topic of wait_event(queue, condition) 
and wake_up(queue) functions. I am quite confused on the sayings. One is 
"Until condition evaluates to a true value, the process continues to 
sleep", which looks like that 'condition' is the one who wake up the 
process from its sleeping. However the other saying is "The basic function 
that wakes up sleeping processes is called wake_up, and wake_up wakes up 
all processes waiting on the given queue" So who is the exact one to wake 
the sleeping process up at all, condition or wake_up? From my 
understanding, if the condition becomes true, then the sleeping process 
will leave its sleeping status and wake up. Then what's the use of wake_up 
function? 

My senario could be described as: in my char device driver, I use one ioctl 
command to initiate a DMA transfer. After all related registers are 
initiated, this process will be put to sleep for saving CPU cycles. In the 
interrupt handler which is for a DMA_done, I wake that process up and 
resume its following executing. With this method, in my application program 
if I release a DMA initiation command, it is a Blocking operation and it 
will wait until the DMA transfer is done. 

Perhaps my question is quite simple or basic. Thanks for any explanation 
and comment on this topic in my senario from you experts. Thanks a lot.

Br
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
