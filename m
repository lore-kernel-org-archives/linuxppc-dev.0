Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B522B6EDF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jul 2011 17:24:15 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p677HsYA025285
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jul 2011 17:17:54 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p677MrMj1450146
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jul 2011 17:22:53 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p677ODLn008779
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jul 2011 17:24:13 +1000
Message-ID: <4E155F15.1030805@linux.vnet.ibm.com>
Date: Thu, 07 Jul 2011 12:54:05 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: {PATCH] Firmware update using the update_flash -f <filename>
	results to soft lockup BUG
References: <4E1543B6.9060800@linux.vnet.ibm.com> <6426.1310019149@neuling.org>
In-Reply-To: <6426.1310019149@neuling.org>
Content-Type: multipart/alternative;
	boundary="------------080309090408040507080807"
Cc: suzukikp@in.ibm.com, antonb@au1.ibm.com, naveedaus@in.ibm.com,
	kenistoj@us.ibm.com, chavez@us.ibm.com, arunbal@in.ibm.com,
	linuxppc-dev@ozlabs.org, jlarrew@us.ibm.com, lxie@us.ibm.com,
	mahesh.salgaonkar@in.ibm.com, Subrata Modak <subrata@linux.vnet.ibm.com>,
	srikar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080309090408040507080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Thursday 07 July 2011 11:42 AM, Michael Neuling wrote:
> In message<4E1543B6.9060800@linux.vnet.ibm.com>  you wrote:
>    
>> Hi ,
>>
>> Problem Description:
>> Firmware update using the update_flash -f<filename>   results to soft lockup
>> BUG
>> FLASH: preparing saved firmware image for flash
>> FLASH: flash image is 50141296 bytes
>> FLASH: performing flash and reboot
>> FLASH: this will take several minutes.  Do not power off!
>> BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]
>>
>> Steps to reproduce:
>> 1. Check the firmware information on the machine (using ASM or lsmcode)
>> 2. Update the system firmware with the update_flash command
>> update_flash -f 01FL350_039_038.img
>> info: Temporary side will be updated with a newer or
>> identical image
>>
>> Projected Flash Update Results:
>> Current T Image: FL350_039
>> Current P Image: FL350_039
>> New T Image:     FL350_039
>> New P Image:     FL350_039
>> Flash image ready...rebooting the system...
>>
>> Broadcast message from root@abc
>> (/dev/hvc0) at 5:25 ...
>>
>> The system is going down for reboot NOW!
>> [root@abc /]# Stopping rhsmcertd[  OK  ]
>> Stopping atd: [  OK  ]
>> Stopping cups: [  OK  ]
>> Stopping abrt daemon: [  OK  ]
>> Stopping sshd: [  OK  ]
>> Shutting down postfix: [  OK  ]
>> Stopping rtas_errd (platform error handling) daemon: [  OK  ]
>> Stopping crond: [  OK  ]
>> Stopping automount: [  OK  ]
>> Stopping HAL daemon: [  OK  ]
>> Stopping iprdump: [  OK  ]
>> Killing mdmonitor: [  OK  ]]
>> Stopping system message bus: [  OK  ]
>> Stopping rpcbind: [  OK  ]
>> Stopping auditd: [  OK  ]
>> Shutting down interface eth0:  [  OK  ]
>> Shutting down loopback interface:  [  OK  ]
>> ip6tables: Flushing firewall rules: [  OK  ]
>> ip6tables: Setting chains to policy ACCEPT: filter [  OK  ]
>> ip6tables: Unloading modules: [  OK  ]
>> iptables: Flushing firewall rules: [  OK  ]
>> iptables: Setting chains to policy ACCEPT: filter [  OK  ]
>> iptables: Unloading modules: [  OK  ]
>> Sending all processes the TERM signal... [  OK  ]
>> Sending all processes the KILL signal... [  OK  ]
>> Saving random seed:  [  OK  ]
>> Turning off swap:  [  OK  ]
>> Turning off quotas:  [  OK  ]
>> Unmounting pipe file systems:  [  OK  ]
>> Unmounting file systems:  [  OK  ]
>> init: Re-executing /sbin/init
>> Please stand by while rebooting the system...
>> Restarting system.
>> FLASH: preparing saved firmware image for flash
>> FLASH: flash image is 50141296 bytes
>> FLASH: performing flash and reboot
>> FLASH: this will take several minutes.  Do not power off!
>> BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]
>>
>> This is solved by the following patch
>>      
> Can you please explain how it fixes it?
>    
Here goes the explanation for the fix.

The flash update is conducted with an RTAS call. The RTAS calls are serialized
by lock_rtas() which uses a spin_lock.

Now there is rtasd which keeps scanning for the RTAS events generated on the
machine. This is performed via workqueue mechanism. The rtas_event_scan() also
uses an RTAS call to scan the events, eventually taking the lock_rtas() before
it issues the request.

The flash update is an operation which takes long time, and hence while we are
at it, anyboy else who wants to make an RTAS call will have to wait until the
update is completed. Now in this case, the rtas_event_scan() is being kicked in
to check for events and it waits a long time on the spin_lock, getting us a
SOFT Lockup.

Before the rtas firmware update starts, all other CPUs should be stopped. Which
means no other CPU should be in lock_rtas(). We do not want other CPUs execute
while FW update is in progress and the system will be rebooted anyway after the
update.


> Also you need a signed off by.
>
> Signed-off-by: Divya  <dipraksh@linux.vnet.ibm.com  <mailto:dipraksh@linux.vnet.ibm.com>>
>
>    
>> --- arch/powerpc/kernel/setup-common.c.orig	2011-07-01 22:41:12.952507971 -
>>      
> 0400
>    
>> +++ arch/powerpc/kernel/setup-common.c	2011-07-01 22:48:31.182507915 -
>>      
> 0400
>    
>> @@ -109,11 +109,12 @@ void machine_shutdown(void)
>>    void machine_restart(char *cmd)
>>    {
>>    	machine_shutdown();
>> -	if (ppc_md.restart)
>> -		ppc_md.restart(cmd);
>>    #ifdef CONFIG_SMP
>> -	smp_send_stop();
>> +        smp_send_stop();
>>      
> Random white space change here.
>
>    
>>    #endif
>> +	if (ppc_md.restart)
>> +		ppc_md.restart(cmd);
>> +	
>>    	printk(KERN_EMERG "System Halted, OK to turn off power\n");
>>    	local_irq_disable();
>>    	while (1) ;
>>
>> Thanks
>> Divya
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>      


--------------080309090408040507080807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On Thursday 07 July 2011 11:42 AM, Michael Neuling wrote:
<blockquote cite="mid:6426.1310019149@neuling.org" type="cite">
  <pre wrap="">In message <a class="moz-txt-link-rfc2396E" href="mailto:4E1543B6.9060800@linux.vnet.ibm.com">&lt;4E1543B6.9060800@linux.vnet.ibm.com&gt;</a> you wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi ,

Problem Description:
Firmware update using the update_flash -f&lt;filename&gt;  results to soft lockup
BUG
FLASH: preparing saved firmware image for flash
FLASH: flash image is 50141296 bytes
FLASH: performing flash and reboot
FLASH: this will take several minutes.  Do not power off!
BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]

Steps to reproduce:
1. Check the firmware information on the machine (using ASM or lsmcode)
2. Update the system firmware with the update_flash command
update_flash -f 01FL350_039_038.img
info: Temporary side will be updated with a newer or
identical image

Projected Flash Update Results:
Current T Image: FL350_039
Current P Image: FL350_039
New T Image:     FL350_039
New P Image:     FL350_039
Flash image ready...rebooting the system...

Broadcast message from root@abc
(/dev/hvc0) at 5:25 ...

The system is going down for reboot NOW!
[root@abc /]# Stopping rhsmcertd[  OK  ]
Stopping atd: [  OK  ]
Stopping cups: [  OK  ]
Stopping abrt daemon: [  OK  ]
Stopping sshd: [  OK  ]
Shutting down postfix: [  OK  ]
Stopping rtas_errd (platform error handling) daemon: [  OK  ]
Stopping crond: [  OK  ]
Stopping automount: [  OK  ]
Stopping HAL daemon: [  OK  ]
Stopping iprdump: [  OK  ]
Killing mdmonitor: [  OK  ]]
Stopping system message bus: [  OK  ]
Stopping rpcbind: [  OK  ]
Stopping auditd: [  OK  ]
Shutting down interface eth0:  [  OK  ]
Shutting down loopback interface:  [  OK  ]
ip6tables: Flushing firewall rules: [  OK  ]
ip6tables: Setting chains to policy ACCEPT: filter [  OK  ]
ip6tables: Unloading modules: [  OK  ]
iptables: Flushing firewall rules: [  OK  ]
iptables: Setting chains to policy ACCEPT: filter [  OK  ]
iptables: Unloading modules: [  OK  ]
Sending all processes the TERM signal... [  OK  ]
Sending all processes the KILL signal... [  OK  ]
Saving random seed:  [  OK  ]
Turning off swap:  [  OK  ]
Turning off quotas:  [  OK  ]
Unmounting pipe file systems:  [  OK  ]
Unmounting file systems:  [  OK  ]
init: Re-executing /sbin/init
Please stand by while rebooting the system...
Restarting system.
FLASH: preparing saved firmware image for flash
FLASH: flash image is 50141296 bytes
FLASH: performing flash and reboot
FLASH: this will take several minutes.  Do not power off!
BUG: soft lockup - CPU#1 stuck for 67s! [events/1:36]

This is solved by the following patch
    </pre>
  </blockquote>
  <pre wrap="">
Can you please explain how it fixes it?
  </pre>
</blockquote>
<pre>Here goes the explanation for the fix.
</pre>
<pre class="bz_comment_text" id="comment_text_37">The flash update is conducted with an RTAS call. The RTAS calls are serialized
by lock_rtas() which uses a spin_lock.

Now there is rtasd which keeps scanning for the RTAS events generated on the
machine. This is performed via workqueue mechanism. The rtas_event_scan() also
uses an RTAS call to scan the events, eventually taking the lock_rtas() before
it issues the request.

The flash update is an operation which takes long time, and hence while we are
at it, anyboy else who wants to make an RTAS call will have to wait until the
update is completed. Now in this case, the rtas_event_scan() is being kicked in
to check for events and it waits a long time on the spin_lock, getting us a
SOFT Lockup.

Before the rtas firmware update starts, all other CPUs should be stopped. Which
means no other CPU should be in lock_rtas(). We do not want other CPUs execute
while FW update is in progress and the system will be rebooted anyway after the
update.

</pre>
<blockquote cite="mid:6426.1310019149@neuling.org" type="cite">
  <pre wrap="">
Also you need a signed off by.

Signed-off-by: Divya<span> &lt;<a class="chatzilla-link"
 href="mailto:dipraksh@linux.vnet.ibm.com">dipraksh@linux.vnet.<wbr>ibm.com<wbr></a>&gt;</span>

  </pre>
  <blockquote type="cite">
    <pre wrap="">
--- arch/powerpc/kernel/setup-common.c.orig	2011-07-01 22:41:12.952507971 -
    </pre>
  </blockquote>
  <pre wrap="">0400
  </pre>
  <blockquote type="cite">
    <pre wrap="">+++ arch/powerpc/kernel/setup-common.c	2011-07-01 22:48:31.182507915 -
    </pre>
  </blockquote>
  <pre wrap="">0400
  </pre>
  <blockquote type="cite">
    <pre wrap="">@@ -109,11 +109,12 @@ void machine_shutdown(void)
  void machine_restart(char *cmd)
  {
  	machine_shutdown();
-	if (ppc_md.restart)
-		ppc_md.restart(cmd);
  #ifdef CONFIG_SMP
-	smp_send_stop();
+        smp_send_stop();
    </pre>
  </blockquote>
  <pre wrap="">
Random white space change here.

  </pre>
  <blockquote type="cite">
    <pre wrap="">  #endif
+	if (ppc_md.restart)
+		ppc_md.restart(cmd);
+	
  	printk(KERN_EMERG "System Halted, OK to turn off power\n");
  	local_irq_disable();
  	while (1) ;

Thanks
Divya

_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a>

    </pre>
  </blockquote>
</blockquote>
<br>
</body>
</html>

--------------080309090408040507080807--
