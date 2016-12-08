Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ51k3DH6zDw32
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 17:24:41 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB86Odor118743
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 01:24:39 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 276y4sav11-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2016 01:24:32 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 8 Dec 2016 11:54:27 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AE06E394005E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 11:54:23 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB86Nl5h28639452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 11:53:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB86OLOR032004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 11:54:22 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_97D09DBB-E392-413D-B230-C48EE2A68D2C"
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: 4.9.0-rc8 - rcutorture test failure
Date: Thu, 8 Dec 2016 11:54:15 +0530
To: linuxppc-dev@lists.ozlabs.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-Id: <53527A2F-3F17-460F-87DE-67034A5325B8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_97D09DBB-E392-413D-B230-C48EE2A68D2C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

RCU Torture test on powerpc fails during its run against latest mainline
(4.9.0-rc8) tree.

07:58:25 BUG: rcutorture tests failed !
07:58:25 21:31:00 ERROR| child process failed
07:58:25 21:31:00 INFO | 		ERROR	rcutorture	=
rcutorture	timestamp=3D1481164260	localtime=3DDec 07 21:31:00=09
07:58:25   BUG: rcutorture tests failed !
07:58:25 21:31:00 INFO | 	END ERROR	rcutorture	=
rcutorture	timestamp=3D1481164260	localtime=3DDec 07 21:31:00=09

I have attached complete rcutorture run log.

Thanks
-Sachin


--Apple-Mail=_97D09DBB-E392-413D-B230-C48EE2A68D2C
Content-Disposition: attachment;
	filename=rcutorture.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="rcutorture.log"
Content-Transfer-Encoding: 7bit

07:19:04 20:51:39 INFO | Test: running rcutorture tests
07:19:04 20:51:39 INFO | rcutorture
07:19:05 20:51:40 INFO | 	START	rcutorture	rcutorture	timestamp=1481161900	localtime=Dec 07 20:51:40	
07:19:05 20:51:40 INFO | Check if CONFIG_RCU_TORTURE_TEST is enabled
07:19:05 
07:19:05 [  418.897476] rcu-torture:--- Start of test: nreaders=79 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
07:19:05 [  418.897843] rcu-torture: Creating rcu_torture_writer task
07:19:05 [  418.897935] rcu-torture: Creating rcu_torture_fakewriter task
07:19:05 [  418.897941] rcu-torture: rcu_torture_writer task started
07:19:05 [  418.898074] rcu-torture: Creating rcu_torture_fakewriter task
07:19:05 [  418.898079] rcu-torture: rcu_torture_fakewriter task started
07:19:05 [  418.898238] rcu-torture: Creating rcu_torture_fakewriter task
07:19:05 [  418.898242] rcu-torture: rcu_torture_fakewriter task started
07:19:05 [  418.898412] rcu-torture: Creating rcu_torture_fakewriter task
07:19:05 [  418.898414] rcu-torture: rcu_torture_fakewriter task started
07:19:05 [  418.898566] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.898569] rcu-torture: rcu_torture_fakewriter task started
07:19:05 [  418.898711] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.898714] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.898840] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.898843] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.898970] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.898973] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899099] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899101] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899227] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899230] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899357] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899360] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899485] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899488] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899630] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899633] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899789] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899790] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.899937] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.899940] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.900077] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.900078] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.900233] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.900236] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.900364] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.900367] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.900587] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.900590] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.900810] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.900813] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.901028] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.901031] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.901247] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.901250] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.901465] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.901468] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.901746] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.901749] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.902024] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.902029] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.902286] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.902291] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.902536] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.902540] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.902781] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.902784] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.903024] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.903028] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.903260] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.903265] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.903482] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.903485] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.903707] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.903710] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.903927] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.903931] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.904136] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.904139] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.904347] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.904351] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.904558] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.904562] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.904769] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.904773] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.904926] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.904929] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905050] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905053] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905175] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905179] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905300] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905304] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905424] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905427] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905549] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905553] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905723] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905745] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.905910] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.905914] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.906090] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.906093] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.906256] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.906259] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.906412] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.906415] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.906618] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.906621] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.906862] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.906866] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.907088] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.907093] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.907309] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.907313] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.907523] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.907526] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.907743] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.907746] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.907990] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.907994] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.908240] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.908245] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.908485] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.908488] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.908731] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.908735] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.908977] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.908980] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.909232] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.909238] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.909487] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.909492] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.909824] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.909830] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.910150] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.910155] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.910438] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.910444] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.910724] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.910729] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.910986] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.910990] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.911173] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.911178] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.911356] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.911362] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.911544] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.911546] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.911756] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.911762] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912007] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912125] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912176] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912179] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912257] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912263] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912327] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912332] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912436] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912481] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912527] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912530] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912628] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912630] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912694] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912698] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912757] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912763] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912894] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912940] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.912979] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.912981] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.913079] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.913081] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.913156] rcu-torture: Creating rcu_torture_reader task
07:19:05 [  418.913165] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.913269] rcu-torture: Creating rcu_torture_stats task
07:19:05 [  418.913313] rcu-torture: rcu_torture_reader task started
07:19:05 [  418.913355] rcu-torture: Creating torture_shuffle task
07:19:05 [  418.913358] rcu-torture: rcu_torture_stats task started
07:19:05 [  418.913452] rcu-torture: Creating torture_stutter task
07:19:05 [  418.913453] rcu-torture: torture_shuffle task started
07:19:05 [  418.913505] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913507] rcu-torture: torture_stutter task started
07:19:05 [  418.913548] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913572] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913596] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913627] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913673] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913697] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913729] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913748] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913779] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913803] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913830] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913851] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913885] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913899] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913933] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.913954] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.913980] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914001] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914028] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914049] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914076] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914097] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914123] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914144] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914171] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914192] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914218] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914240] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914266] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914287] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914315] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914338] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914366] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914389] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914421] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914436] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914469] rcu-torture: Creating rcu_torture_cbflood task
07:19:05 [  418.914491] rcu-torture: rcu_torture_cbflood task started
07:19:05 [  418.914539] rcu-torture: rcu_torture_cbflood task started
07:19:20 [  433.951425] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951431] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951434] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951439] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951441] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951446] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951450] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951453] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951457] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951462] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951465] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951468] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951473] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951476] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951478] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951481] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951484] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951487] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951490] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951493] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951496] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951500] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951502] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951505] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951508] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951511] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951514] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951518] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951521] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951525] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951528] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951531] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951535] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951539] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951542] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951545] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951549] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951552] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951556] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951558] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951561] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951563] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951566] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951568] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951571] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951575] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951577] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951580] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951582] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951587] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951589] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951590] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951593] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951596] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951597] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951600] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951602] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951605] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951607] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951610] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951613] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951615] rcu-torture: Stopping torture_shuffle task
07:19:20 [  433.951618] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951620] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951622] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951624] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951626] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951628] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951630] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951633] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951635] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951637] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951642] rcu-torture: Stopping torture_shuffle
07:19:20 [  433.951643] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951645] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951647] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951649] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951651] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951652] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951653] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951655] rcu-torture: Stopping rcu_torture_reader
07:19:20 [  433.951656] rcu-torture: Stopping torture_stutter task
07:19:20 [  433.957457] rcu-torture: Stopping torture_stutter
07:19:20 [  433.957459] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 [  433.957679] rcu-torture: Stopping rcu_torture_writer task
07:19:20 [  433.969432] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 [  433.969433] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 [  433.985424] rcu-torture: Stopping rcu_torture_writer
07:19:20 [  433.985431] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 [  433.985652] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.985783] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.985906] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986023] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986138] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986254] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986367] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986481] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986597] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986707] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986817] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.986924] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987028] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987131] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987239] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987349] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987458] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987571] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987677] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987781] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987888] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.987993] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988097] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988203] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988308] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988393] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988455] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988521] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988581] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988647] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988711] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988775] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988839] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988902] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.988961] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989027] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989090] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989154] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989216] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989277] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989342] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989406] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989637] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989702] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989763] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989832] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989901] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.989975] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990039] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990102] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990166] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990229] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990292] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990355] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990423] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990484] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990550] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990619] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990729] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990837] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.990940] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991051] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991159] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991268] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991371] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991483] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991587] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991695] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991804] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.991907] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992013] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992122] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992237] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992353] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992460] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992567] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992681] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992787] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.992897] rcu-torture: Stopping rcu_torture_reader task
07:19:20 [  433.993005] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 [  433.993133] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 [  433.993260] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 [  433.993388] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 [  433.993538] rcu-torture: Stopping rcu_torture_stats task
07:19:20 [  433.993665] rcu-torture: rtc:           (null) ver: 220 tfle: 0 rta: 220 rtaf: 0 rtf: 206 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 82827 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 180
07:19:20 [  433.994076] rcu-torture: Reader Pipe:  1336954003 3581 0 0 0 0 0 0 0 0 0
07:19:20 [  433.994421] rcu-torture: Reader Batch:  1224323997 112633316 0 0 0 0 0 0 0 0 0
07:19:20 [  433.994760] rcu-torture: Free-Block Circulation:  219 219 217 216 215 213 212 209 208 206 0
07:19:20 [  433.995124] rcu-torture: Stopping rcu_torture_stats
07:19:20 [  433.995180] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  433.997663] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077450] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077459] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077478] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077491] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077492] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.077494] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077500] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077501] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077504] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077509] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.077518] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077519] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077520] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077529] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077538] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077546] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.077552] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.077554] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.141444] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.141557] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.141626] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.141694] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.141759] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.141825] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.141891] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.141955] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.142018] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.213436] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.213518] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.273428] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.273512] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.273549] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.273618] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.321810] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 [  434.321899] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.321950] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.322016] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.322078] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 [  434.353435] rcu-torture: rtc:           (null) ver: 220 tfle: 0 rta: 220 rtaf: 0 rtf: 206 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 82827 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 184
07:19:20 [  434.353580] rcu-torture: Reader Pipe:  1336954003 3581 0 0 0 0 0 0 0 0 0
07:19:20 [  434.353769] rcu-torture: Reader Batch:  1224323997 112633316 0 0 0 0 0 0 0 0 0
07:19:20 [  434.353957] rcu-torture: Free-Block Circulation:  219 219 217 216 215 213 212 209 208 206 0
07:19:20 [  434.354162] rcu-torture:--- End of test: SUCCESS: nreaders=79 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
07:19:20 20:51:55 INFO | [  418.897476] rcu-torture:--- Start of test: nreaders=79 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
07:19:20 20:51:55 INFO | [  418.897843] rcu-torture: Creating rcu_torture_writer task
07:19:20 20:51:55 INFO | [  418.897935] rcu-torture: Creating rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  418.897941] rcu-torture: rcu_torture_writer task started
07:19:20 20:51:55 INFO | [  418.898074] rcu-torture: Creating rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  418.898079] rcu-torture: rcu_torture_fakewriter task started
07:19:20 20:51:55 INFO | [  418.898238] rcu-torture: Creating rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  418.898242] rcu-torture: rcu_torture_fakewriter task started
07:19:20 20:51:55 INFO | [  418.898412] rcu-torture: Creating rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  418.898414] rcu-torture: rcu_torture_fakewriter task started
07:19:20 20:51:55 INFO | [  418.898566] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.898569] rcu-torture: rcu_torture_fakewriter task started
07:19:20 20:51:55 INFO | [  418.898711] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.898714] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.898840] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.898843] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.898970] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.898973] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899099] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899101] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899227] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899230] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899357] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899360] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899485] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899488] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899630] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899633] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899789] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899790] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.899937] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.899940] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.900077] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.900078] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.900233] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.900236] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.900364] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.900367] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.900587] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.900590] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.900810] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.900813] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.901028] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.901031] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.901247] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.901250] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.901465] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.901468] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.901746] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.901749] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.902024] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.902029] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.902286] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.902291] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.902536] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.902540] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.902781] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.902784] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.903024] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.903028] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.903260] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.903265] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.903482] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.903485] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.903707] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.903710] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.903927] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.903931] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.904136] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.904139] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.904347] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.904351] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.904558] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.904562] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.904769] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.904773] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.904926] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.904929] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905050] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905053] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905175] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905179] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905300] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905304] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905424] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905427] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905549] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905553] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905723] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905745] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.905910] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.905914] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.906090] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.906093] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.906256] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.906259] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.906412] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.906415] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.906618] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.906621] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.906862] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.906866] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.907088] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.907093] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.907309] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.907313] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.907523] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.907526] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.907743] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.907746] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.907990] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.907994] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.908240] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.908245] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.908485] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.908488] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.908731] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.908735] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.908977] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.908980] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.909232] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.909238] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.909487] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.909492] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.909824] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.909830] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.910150] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.910155] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.910438] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.910444] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.910724] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.910729] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.910986] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.910990] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.911173] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.911178] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.911356] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.911362] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.911544] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.911546] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.911756] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.911762] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912007] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912125] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912176] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912179] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912257] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912263] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912327] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912332] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912436] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912481] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912527] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912530] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912628] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912630] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912694] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912698] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912757] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912763] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912894] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912940] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.912979] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.912981] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.913079] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.913081] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.913156] rcu-torture: Creating rcu_torture_reader task
07:19:20 20:51:55 INFO | [  418.913165] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.913269] rcu-torture: Creating rcu_torture_stats task
07:19:20 20:51:55 INFO | [  418.913313] rcu-torture: rcu_torture_reader task started
07:19:20 20:51:55 INFO | [  418.913355] rcu-torture: Creating torture_shuffle task
07:19:20 20:51:55 INFO | [  418.913358] rcu-torture: rcu_torture_stats task started
07:19:20 20:51:55 INFO | [  418.913452] rcu-torture: Creating torture_stutter task
07:19:20 20:51:55 INFO | [  418.913453] rcu-torture: torture_shuffle task started
07:19:20 20:51:55 INFO | [  418.913505] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913507] rcu-torture: torture_stutter task started
07:19:20 20:51:55 INFO | [  418.913548] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913572] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913596] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913627] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913673] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913697] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913729] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913748] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913779] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913803] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913830] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913851] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913885] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913899] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913933] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.913954] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.913980] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914001] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914028] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914049] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914076] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914097] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914123] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914144] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914171] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914192] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914218] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914240] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914266] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914287] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914315] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914338] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914366] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914389] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914421] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914436] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914469] rcu-torture: Creating rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  418.914491] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  418.914539] rcu-torture: rcu_torture_cbflood task started
07:19:20 20:51:55 INFO | [  433.951425] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951431] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951434] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951439] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951441] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951446] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951450] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951453] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951457] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951462] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951465] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951468] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951473] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951476] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951478] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951481] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951484] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951487] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951490] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951493] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951496] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951500] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951502] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951505] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951508] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951511] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951514] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951518] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951521] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951525] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951528] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951531] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951535] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951539] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951542] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951545] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951549] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951552] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951556] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951558] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951561] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951563] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951566] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951568] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951571] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951575] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951577] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951580] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951582] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951587] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951589] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951590] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951593] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951596] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951597] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951600] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951602] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951605] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951607] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951610] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951613] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951615] rcu-torture: Stopping torture_shuffle task
07:19:20 20:51:55 INFO | [  433.951618] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951620] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951622] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951624] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951626] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951628] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951630] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951633] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951635] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951637] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951642] rcu-torture: Stopping torture_shuffle
07:19:20 20:51:55 INFO | [  433.951643] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951645] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951647] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951649] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951651] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951652] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951653] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951655] rcu-torture: Stopping rcu_torture_reader
07:19:20 20:51:55 INFO | [  433.951656] rcu-torture: Stopping torture_stutter task
07:19:20 20:51:55 INFO | [  433.957457] rcu-torture: Stopping torture_stutter
07:19:20 20:51:55 INFO | [  433.957459] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 20:51:55 INFO | [  433.957679] rcu-torture: Stopping rcu_torture_writer task
07:19:20 20:51:55 INFO | [  433.969432] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 20:51:55 INFO | [  433.969433] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 20:51:55 INFO | [  433.985424] rcu-torture: Stopping rcu_torture_writer
07:19:20 20:51:55 INFO | [  433.985431] rcu-torture: Stopping rcu_torture_fakewriter
07:19:20 20:51:55 INFO | [  433.985652] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.985783] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.985906] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986023] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986138] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986254] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986367] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986481] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986597] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986707] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986817] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.986924] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987028] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987131] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987239] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987349] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987458] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987571] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987677] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987781] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987888] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.987993] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988097] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988203] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988308] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988393] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988455] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988521] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988581] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988647] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988711] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988775] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988839] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988902] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.988961] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989027] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989090] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989154] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989216] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989277] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989342] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989406] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989637] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989702] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989763] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989832] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989901] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.989975] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990039] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990102] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990166] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990229] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990292] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990355] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990423] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990484] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990550] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990619] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990729] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990837] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.990940] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991051] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991159] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991268] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991371] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991483] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991587] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991695] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991804] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.991907] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992013] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992122] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992237] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992353] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992460] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992567] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992681] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992787] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.992897] rcu-torture: Stopping rcu_torture_reader task
07:19:20 20:51:55 INFO | [  433.993005] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  433.993133] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  433.993260] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  433.993388] rcu-torture: Stopping rcu_torture_fakewriter task
07:19:20 20:51:55 INFO | [  433.993538] rcu-torture: Stopping rcu_torture_stats task
07:19:20 20:51:55 INFO | [  433.993665] rcu-torture: rtc:           (null) ver: 220 tfle: 0 rta: 220 rtaf: 0 rtf: 206 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 82827 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 180
07:19:20 20:51:55 INFO | [  433.994076] rcu-torture: Reader Pipe:  1336954003 3581 0 0 0 0 0 0 0 0 0
07:19:20 20:51:55 INFO | [  433.994421] rcu-torture: Reader Batch:  1224323997 112633316 0 0 0 0 0 0 0 0 0
07:19:20 20:51:55 INFO | [  433.994760] rcu-torture: Free-Block Circulation:  219 219 217 216 215 213 212 209 208 206 0
07:19:20 20:51:55 INFO | [  433.995124] rcu-torture: Stopping rcu_torture_stats
07:19:20 20:51:55 INFO | [  433.995180] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  433.997663] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077450] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077459] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077478] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077491] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077492] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  434.077494] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077500] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077501] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077504] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077509] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  434.077518] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077519] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077520] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077529] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077538] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077546] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.077552] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  434.077554] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.141444] rcu-torture: Stopping rcu_torture_cbflood
07:19:20 20:51:55 INFO | [  434.141557] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 20:51:55 INFO | [  434.141626] rcu-torture: Stopping rcu_torture_cbflood task
07:19:20 20:51:55 INFrture_reader task started
07:19:20 [  434.656149] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.656152] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.656367] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.656370] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.656587] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.656590] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.656809] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.656812] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.657025] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.657028] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.657254] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.657257] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.657529] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.657536] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.657800] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.657803] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.658036] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.658039] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.658264] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.658268] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.658497] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.658500] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.658637] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.658640] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.658769] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.658772] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.658897] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.658901] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659023] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659026] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659149] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659153] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659276] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659280] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659403] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659407] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659527] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659531] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659652] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659656] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659776] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659780] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.659903] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.659907] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660027] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660031] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660152] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660156] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660276] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660280] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660401] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660405] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660526] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660529] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660650] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660654] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660774] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660778] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.660898] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.660902] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.661026] rcu-torture: Creating rcu_torture_reader task
07:19:20 [  434.661030] rcu-torture: rcu_torture_reader task started
07:19:20 [  434.661238] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.661241] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.661489] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.661492] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.661756] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.661760] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.662023] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.662026] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.662277] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.662280] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.662522] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.662525] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.662771] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.662774] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.663021] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.663024] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.663279] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.663283] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.663534] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.663537] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.663792] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.663795] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.664050] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.664054] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.664296] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.664299] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.664555] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.664560] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.664812] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.664818] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.665067] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.665071] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.665325] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.665328] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.665769] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.665771] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.666002] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.666004] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.666196] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.666202] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.666414] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.666421] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.666608] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.666612] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.666987] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.666989] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.667182] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.667189] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.667370] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.667377] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.667557] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.667565] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.667743] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.667749] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.667926] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.667932] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.668125] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.668132] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.668334] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.668342] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.668541] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.668549] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.668741] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.668748] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.668942] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.668950] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.669139] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.669141] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.669389] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.669776] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.669782] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.669803] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.670236] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.670244] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.670573] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.670582] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.670873] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.671029] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.671065] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.671125] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.671162] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.671212] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.673443] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.673445] rcu-torture: Creating rcu_torture_reader task
07:19:21 [  434.673521] rcu-torture: Creating rcu_torture_stats task
07:19:21 [  434.673535] rcu-torture: rcu_torture_reader task started
07:19:21 [  434.677453] rcu-torture: Creating torture_shuffle task
07:19:21 [  434.677460] rcu-torture: rcu_torture_stats task started
07:19:21 [  434.681440] rcu-torture: Creating torture_stutter task
07:19:21 [  434.681448] rcu-torture: torture_shuffle task started
07:19:21 [  434.685726] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.685732] rcu-torture: torture_stutter task started
07:19:21 [  434.687196] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.687230] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.689899] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.689927] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.690405] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.690433] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.693454] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.693482] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.697715] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.697744] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.701246] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.701274] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.705466] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.705491] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.709702] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.709731] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.713718] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.713746] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.715129] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.715157] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.717456] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.717478] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.721703] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.721731] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.725697] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.725726] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.729707] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.729736] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.733708] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.733736] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.737704] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.737732] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.741706] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.741735] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.745707] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.745737] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.749705] rcu-torture: Creating rcu_torture_cbflood task
07:19:21 [  434.749733] rcu-torture: rcu_torture_cbflood task started
07:19:21 [  434.751346] rcu-torture: rcu_torture_cbflood task started
07:19:21 20:51:56 INFO | Online all cpus 80
07:19:31 20:52:06 INFO | Offline all cpus 0 - 79
07:19:31 
07:20:03 20:52:38 INFO | Online all cpus 0 - 79
07:20:03 
07:20:15 20:52:50 INFO | Offline and online first half cpus 0 - 39
07:20:15 
07:20:22 [  496.608794] rcu-torture: rtc: d00000000c0bc1b0 ver: 917 tfle: 0 rta: 918 rtaf: 0 rtf: 904 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 174237 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 548
07:20:22 [  496.609066] rcu-torture: Reader Pipe:  2631197873 6104 0 0 0 0 0 0 0 0 0
07:20:22 [  496.609317] rcu-torture: Reader Batch:  2386634984 244568431 0 0 0 0 0 0 0 0 0
07:20:22 [  496.609563] rcu-torture: Free-Block Circulation:  917 916 915 914 911 910 909 906 905 904 0
07:21:24 [  558.044247] rcu-torture: rtc: d00000000c0bc690 ver: 1548 tfle: 0 rta: 1549 rtaf: 0 rtf: 1535 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 445198 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 1148
07:21:24 [  558.044599] rcu-torture: Reader Pipe:  6941790682 17017 0 0 0 0 0 0 0 0 0
07:21:24 [  558.044851] rcu-torture: Reader Batch:  6231778356 710027924 0 0 0 0 0 0 0 0 0
07:21:24 [  558.045101] rcu-torture: Free-Block Circulation:  1548 1546 1545 1544 1543 1540 1539 1538 1536 1535 0
07:22:25 [  619.483621] rcu-torture: rtc: d00000000c0bcae0 ver: 2152 tfle: 0 rta: 2153 rtaf: 0 rtf: 2141 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 716785 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 1731
07:22:25 [  619.483910] rcu-torture: Reader Pipe:  11279345699 27087 0 0 0 0 0 0 0 0 0
07:22:25 [  619.484170] rcu-torture: Reader Batch:  10117105572 1162264970 0 0 0 0 0 0 0 0 0
07:22:25 [  619.484431] rcu-torture: Free-Block Circulation:  2152 2151 2150 2149 2147 2145 2144 2143 2142 2141 0
07:23:27 [  680.923061] rcu-torture: rtc: d00000000c0bc660 ver: 2838 tfle: 0 rta: 2839 rtaf: 0 rtf: 2827 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 989890 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 2331
07:23:27 [  680.923326] rcu-torture: Reader Pipe:  15627853254 38638 0 0 0 0 0 0 0 0 0
07:23:27 [  680.923606] rcu-torture: Reader Batch:  13995695481 1632193330 0 0 0 0 0 0 0 0 0
07:23:27 [  680.923885] rcu-torture: Free-Block Circulation:  2838 2837 2836 2834 2833 2832 2831 2829 2828 2827 0
07:24:28 [  742.362495] rcu-torture: rtc: d00000000c0bcff0 ver: 3510 tfle: 0 rta: 3511 rtaf: 0 rtf: 3498 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1266263 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 2930
07:24:28 [  742.362778] rcu-torture: Reader Pipe:  19951131848 49929 0 0 0 0 0 0 0 0 0
07:24:28 [  742.363059] rcu-torture: Reader Batch:  17850130562 2101047363 0 0 0 0 0 0 0 0 0
07:24:28 [  742.363342] rcu-torture: Free-Block Circulation:  3510 3508 3507 3506 3503 3502 3501 3500 3499 3498 0
07:25:30 [  803.805940] rcu-torture: rtc: d00000000c0bcab0 ver: 4154 tfle: 0 rta: 4155 rtaf: 0 rtf: 4141 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1540840 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 3530
07:25:30 [  803.806322] rcu-torture: Reader Pipe:  24290514367 60560 0 0 0 0 0 0 0 0 0
07:25:30 [  803.806604] rcu-torture: Reader Batch:  21752837685 2537732518 0 0 0 0 0 0 0 0 0
07:25:30 [  803.806888] rcu-torture: Free-Block Circulation:  4154 4153 4152 4151 4150 4149 4146 4144 4142 4141 0
07:26:31 [  865.241377] rcu-torture: rtc: d00000000c0bc210 ver: 4799 tfle: 0 rta: 4800 rtaf: 0 rtf: 4786 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1810770 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 4118
07:26:31 [  865.241748] rcu-torture: Reader Pipe:  28617034150 71462 0 0 0 0 0 0 0 0 0
07:26:31 [  865.242023] rcu-torture: Reader Batch:  25706841786 2910258414 0 0 0 0 0 0 0 0 0
07:26:31 [  865.242298] rcu-torture: Free-Block Circulation:  4799 4798 4797 4794 4793 4790 4789 4788 4787 4786 0
07:27:04 20:59:39 INFO | Offline and online second half cpus 40 - 79
07:27:04 
07:27:33 [  926.684839] rcu-torture: rtc: d00000000c0bcb40 ver: 5452 tfle: 0 rta: 5453 rtaf: 0 rtf: 5438 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 2081321 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 4718
07:27:33 [  926.685152] rcu-torture: Reader Pipe:  32935402962 82505 0 0 0 0 0 0 0 0 0
07:27:33 [  926.685412] rcu-torture: Reader Batch:  29604150841 3331328537 0 0 0 0 0 0 0 0 0
07:27:33 [  926.685692] rcu-torture: Free-Block Circulation:  5452 5450 5449 5446 5444 5443 5442 5441 5439 5438 0
07:28:34 [  988.124340] rcu-torture: rtc: d00000000c0bd110 ver: 6106 tfle: 0 rta: 6107 rtaf: 0 rtf: 6092 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 2352606 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 5318
07:28:34 [  988.124719] rcu-torture: Reader Pipe:  37259723982 93240 0 0 0 0 0 0 0 0 0
07:28:34 [  988.125001] rcu-torture: Reader Batch:  33465995956 3793814444 0 0 0 0 0 0 0 0 0
07:28:34 [  988.125279] rcu-torture: Free-Block Circulation:  6106 6104 6103 6102 6101 6100 6098 6097 6093 6092 0
07:29:35 [ 1049.583459] rcu-torture: rtc: d00000000c0bcf30 ver: 6782 tfle: 0 rta: 6782 rtaf: 0 rtf: 6770 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 2623621 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 5918
07:29:35 [ 1049.583808] rcu-torture: Reader Pipe:  41578723847 104315 0 0 0 0 0 0 0 0 0
07:29:35 [ 1049.584091] rcu-torture: Reader Batch:  37308103276 4270717226 0 0 0 0 0 0 0 0 0
07:29:35 [ 1049.584372] rcu-torture: Free-Block Circulation:  6782 6779 6778 6777 6776 6775 6774 6772 6771 6770 0
07:30:37 [ 1110.997694] rcu-torture: rtc: d00000000c0bc1e0 ver: 7398 tfle: 0 rta: 7399 rtaf: 0 rtf: 7389 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 2897108 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 6518
07:30:37 [ 1110.997952] rcu-torture: Reader Pipe:  45920315848 114665 0 0 0 0 0 0 0 0 0
07:30:37 [ 1110.998231] rcu-torture: Reader Batch:  41182776175 4737645904 0 0 0 0 0 0 0 0 0
07:30:37 [ 1110.998510] rcu-torture: Free-Block Circulation:  7398 7397 7396 7395 7394 7393 7392 7391 7390 7389 0
07:31:38 [ 1172.435042] rcu-torture: rtc: d00000000c0bc660 ver: 8050 tfle: 0 rta: 8051 rtaf: 0 rtf: 8034 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3172028 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 7118
07:31:38 [ 1172.435427] rcu-torture: Reader Pipe:  50253098478 125492 0 0 0 0 0 0 0 0 0
07:31:38 [ 1172.435710] rcu-torture: Reader Batch:  45057226875 5195987804 0 0 0 0 0 0 0 0 0
07:31:38 [ 1172.435992] rcu-torture: Free-Block Circulation:  8050 8046 8045 8044 8043 8042 8039 8038 8035 8034 0
07:32:40 [ 1233.876924] rcu-torture: rtc: d00000000c0bc8a0 ver: 8667 tfle: 0 rta: 8668 rtaf: 0 rtf: 8656 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3447038 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 7718
07:32:40 [ 1233.877304] rcu-torture: Reader Pipe:  54575910784 135981 0 0 0 0 0 0 0 0 0
07:32:40 [ 1233.877589] rcu-torture: Reader Batch:  49037763663 5538272889 0 0 0 0 0 0 0 0 0
07:32:40 [ 1233.877866] rcu-torture: Free-Block Circulation:  8667 8666 8664 8663 8662 8661 8660 8658 8657 8656 0
07:33:41 [ 1295.310888] rcu-torture: rtc: d00000000c0bd050 ver: 9308 tfle: 0 rta: 9309 rtaf: 0 rtf: 9294 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3717267 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 8316
07:33:41 [ 1295.311274] rcu-torture: Reader Pipe:  58917621056 146529 0 0 0 0 0 0 0 0 0
07:33:41 [ 1295.311552] rcu-torture: Reader Batch:  52893553906 6024202609 0 0 0 0 0 0 0 0 0
07:33:41 [ 1295.311835] rcu-torture: Free-Block Circulation:  9308 9304 9303 9301 9299 9298 9297 9296 9295 9294 0
07:34:43 [ 1356.753220] rcu-torture: rtc: d00000000c0bd080 ver: 9916 tfle: 0 rta: 9917 rtaf: 0 rtf: 9905 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3988026 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 8916
07:34:43 [ 1356.753514] rcu-torture: Reader Pipe:  63237680606 156921 0 0 0 0 0 0 0 0 0
07:34:43 [ 1356.753797] rcu-torture: Reader Batch:  56781318566 6456507114 0 0 0 0 0 0 0 0 0
07:34:43 [ 1356.754080] rcu-torture: Free-Block Circulation:  9916 9915 9913 9911 9910 9909 9908 9907 9906 9905 0
07:35:44 [ 1418.187683] rcu-torture: rtc: d00000000c0bca50 ver: 10577 tfle: 0 rta: 10578 rtaf: 0 rtf: 10565 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4259070 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 9516
07:35:44 [ 1418.188060] rcu-torture: Reader Pipe:  67566940591 167927 0 0 0 0 0 0 0 0 0
07:35:44 [ 1418.188328] rcu-torture: Reader Batch:  60664172380 6902923478 0 0 0 0 0 0 0 0 0
07:35:44 [ 1418.188610] rcu-torture: Free-Block Circulation:  10577 10576 10574 10573 10572 10571 10568 10567 10566 10565 0
07:36:45 [ 1479.630361] rcu-torture: rtc: d00000000c0bc5a0 ver: 11241 tfle: 0 rta: 11242 rtaf: 0 rtf: 11228 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4530417 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 10116
07:36:45 [ 1479.630751] rcu-torture: Reader Pipe:  71902194690 179163 0 0 0 0 0 0 0 0 0
07:36:45 [ 1479.631031] rcu-torture: Reader Batch:  64557172348 7345188051 0 0 0 0 0 0 0 0 0
07:36:45 [ 1479.631311] rcu-torture: Free-Block Circulation:  11241 11240 11238 11236 11234 11233 11232 11230 11229 11228 0
07:37:47 [ 1541.069108] rcu-torture: rtc: d00000000c0bcf00 ver: 11874 tfle: 0 rta: 11875 rtaf: 0 rtf: 11865 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4802187 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 10716
07:37:47 [ 1541.069396] rcu-torture: Reader Pipe:  76232938251 189785 0 0 0 0 0 0 0 0 0
07:37:47 [ 1541.069675] rcu-torture: Reader Batch:  68382539678 7850574108 0 0 0 0 0 0 0 0 0
07:37:47 [ 1541.069952] rcu-torture: Free-Block Circulation:  11874 11873 11872 11871 11870 11869 11868 11867 11866 11865 0
07:38:48 [ 1602.503982] rcu-torture: rtc: d00000000c0bd140 ver: 12500 tfle: 0 rta: 12501 rtaf: 0 rtf: 12486 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5074363 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 11316
07:38:48 [ 1602.504349] rcu-torture: Reader Pipe:  80555593817 200549 0 0 0 0 0 0 0 0 0
07:38:48 [ 1602.504612] rcu-torture: Reader Batch:  72254753920 8301025468 0 0 0 0 0 0 0 0 0
07:38:48 [ 1602.504891] rcu-torture: Free-Block Circulation:  12500 12499 12497 12496 12493 12492 12489 12488 12487 12486 0
07:39:50 [ 1663.942768] rcu-torture: rtc: d00000000c0bc8a0 ver: 13167 tfle: 0 rta: 13168 rtaf: 0 rtf: 13155 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5350018 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 11916
07:39:50 [ 1663.943145] rcu-torture: Reader Pipe:  84869416712 211582 0 0 0 0 0 0 0 0 0
07:39:50 [ 1663.943424] rcu-torture: Reader Batch:  76098105781 8771506689 0 0 0 0 0 0 0 0 0
07:39:50 [ 1663.943703] rcu-torture: Free-Block Circulation:  13167 13164 13163 13161 13160 13159 13158 13157 13156 13155 0
07:40:51 [ 1725.381777] rcu-torture: rtc: d00000000c0bcc90 ver: 13832 tfle: 0 rta: 13833 rtaf: 0 rtf: 13822 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5623000 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 12516
07:40:51 [ 1725.382164] rcu-torture: Reader Pipe:  89190982684 222539 0 0 0 0 0 0 0 0 0
07:40:51 [ 1725.382438] rcu-torture: Reader Batch:  79971926419 9219262230 0 0 0 0 0 0 0 0 0
07:40:51 [ 1725.382717] rcu-torture: Free-Block Circulation:  13832 13831 13830 13829 13828 13827 13826 13825 13823 13822 0
07:41:53 [ 1786.824822] rcu-torture: rtc: d00000000c0bc8d0 ver: 14467 tfle: 0 rta: 14468 rtaf: 0 rtf: 14452 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5897815 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 13115
07:41:53 [ 1786.825199] rcu-torture: Reader Pipe:  93518648606 233164 0 0 0 0 0 0 0 0 0
07:41:53 [ 1786.825477] rcu-torture: Reader Batch:  83870124829 9648739597 0 0 0 0 0 0 0 0 0
07:41:53 [ 1786.825758] rcu-torture: Free-Block Circulation:  14467 14466 14465 14463 14459 14456 14455 14454 14453 14452 0
07:42:54 [ 1848.259781] rcu-torture: rtc: d00000000c0bbfa0 ver: 15117 tfle: 0 rta: 15118 rtaf: 0 rtf: 15106 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 6170948 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 13715
07:42:54 [ 1848.260168] rcu-torture: Reader Pipe:  97838075377 244140 0 0 0 0 0 0 0 0 0
07:42:54 [ 1848.260467] rcu-torture: Reader Batch:  87750546792 10087754516 0 0 0 0 0 0 0 0 0
07:42:54 [ 1848.260747] rcu-torture: Free-Block Circulation:  15117 15116 15115 15114 15111 15110 15109 15108 15107 15106 0
07:43:53 21:16:28 INFO | Online all cpus 80
07:43:56 [ 1909.698846] rcu-torture: rtc: d00000000c0bca20 ver: 15768 tfle: 0 rta: 15769 rtaf: 0 rtf: 15756 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 6445153 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 14314
07:43:56 [ 1909.699161] rcu-torture: Reader Pipe:  102160025086 255540 0 0 0 0 0 0 0 0 0
07:43:56 [ 1909.699441] rcu-torture: Reader Batch:  91632035668 10528225919 0 0 0 0 0 0 0 0 0
07:43:56 [ 1909.699719] rcu-torture: Free-Block Circulation:  15768 15767 15765 15764 15763 15761 15759 15758 15757 15756 0
07:44:04 21:16:39 INFO | Offline all cpus 0 - 79
07:44:04 
07:44:32 21:17:07 INFO | Online all cpus 0 - 79
07:44:32 
07:44:46 21:17:21 INFO | Offline and online first half cpus 0 - 39
07:44:46 
07:44:57 [ 1971.137965] rcu-torture: rtc: d00000000c0bc420 ver: 16642 tfle: 0 rta: 16643 rtaf: 0 rtf: 16633 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 6637137 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 14863
07:44:57 [ 1971.138326] rcu-torture: Reader Pipe:  104868340430 262116 0 0 0 0 0 0 0 0 0
07:44:57 [ 1971.138580] rcu-torture: Reader Batch:  94025881963 10842700985 0 0 0 0 0 0 0 0 0
07:44:57 [ 1971.138831] rcu-torture: Free-Block Circulation:  16642 16641 16640 16639 16638 16637 16636 16635 16634 16633 0
07:45:58 [ 2032.581024] rcu-torture: rtc: d00000000c0bc060 ver: 17217 tfle: 0 rta: 17218 rtaf: 0 rtf: 17207 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 6908013 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 15459
07:45:58 [ 2032.581347] rcu-torture: Reader Pipe:  109182389115 271684 0 0 0 0 0 0 0 0 0
07:45:58 [ 2032.581631] rcu-torture: Reader Batch:  97939437624 11243202853 0 0 0 0 0 0 0 0 0
07:45:58 [ 2032.581912] rcu-torture: Free-Block Circulation:  17217 17216 17215 17214 17213 17212 17210 17209 17208 17207 0
07:47:00 [ 2094.016218] rcu-torture: rtc: d00000000c0bcdb0 ver: 17864 tfle: 0 rta: 17864 rtaf: 0 rtf: 17853 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 7179647 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 16059
07:47:00 [ 2094.016599] rcu-torture: Reader Pipe:  113524450418 282217 0 0 0 0 0 0 0 0 0
07:47:00 [ 2094.016879] rcu-torture: Reader Batch:  101799404473 11725307174 0 0 0 0 0 0 0 0 0
07:47:00 [ 2094.017160] rcu-torture: Free-Block Circulation:  17863 17863 17862 17861 17860 17859 17858 17857 17854 17853 0
07:48:01 [ 2155.455481] rcu-torture: rtc: d00000000c0bcd20 ver: 18465 tfle: 0 rta: 18466 rtaf: 0 rtf: 18449 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 7450264 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 16659
07:48:01 [ 2155.455858] rcu-torture: Reader Pipe:  117854431015 292334 0 0 0 0 0 0 0 0 0
07:48:01 [ 2155.456137] rcu-torture: Reader Batch:  105647068523 12207633005 0 0 0 0 0 0 0 0 0
07:48:01 [ 2155.456416] rcu-torture: Free-Block Circulation:  18465 18463 18462 18460 18457 18456 18454 18453 18452 18449 0
07:49:03 [ 2216.894817] rcu-torture: rtc: d00000000c0bc540 ver: 19141 tfle: 0 rta: 19142 rtaf: 0 rtf: 19127 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 7726467 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 17256
07:49:03 [ 2216.895216] rcu-torture: Reader Pipe:  122174590260 303535 0 0 0 0 0 0 0 0 0
07:49:03 [ 2216.895493] rcu-torture: Reader Batch:  109497475556 12677395631 0 0 0 0 0 0 0 0 0
07:49:03 [ 2216.895768] rcu-torture: Free-Block Circulation:  19141 19139 19137 19136 19135 19134 19133 19131 19128 19127 0
07:50:04 [ 2278.334249] rcu-torture: rtc: d00000000c0bc5d0 ver: 19831 tfle: 0 rta: 19832 rtaf: 0 rtf: 19818 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 8001345 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 17838
07:50:04 [ 2278.334529] rcu-torture: Reader Pipe:  126525616992 314645 0 0 0 0 0 0 0 0 0
07:50:04 [ 2278.334810] rcu-torture: Reader Batch:  113386167123 13139741079 0 0 0 0 0 0 0 0 0
07:50:04 [ 2278.335091] rcu-torture: Free-Block Circulation:  19831 19828 19826 19824 19823 19822 19821 19820 19819 19818 0
07:51:06 [ 2339.773437] rcu-torture: rtc: d00000000c0bc5a0 ver: 20460 tfle: 0 rta: 20461 rtaf: 0 rtf: 20447 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 8277820 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 18438
07:51:06 [ 2339.773726] rcu-torture: Reader Pipe:  130850209931 324989 0 0 0 0 0 0 0 0 0
07:51:06 [ 2339.774005] rcu-torture: Reader Batch:  117261089557 13589421074 0 0 0 0 0 0 0 0 0
07:51:06 [ 2339.774276] rcu-torture: Free-Block Circulation:  20460 20459 20458 20455 20453 20452 20450 20449 20448 20447 0
07:51:35 21:24:10 INFO | Offline and online second half cpus 40 - 79
07:51:35 
07:52:07 [ 2401.216804] rcu-torture: rtc: d00000000c0bccf0 ver: 21068 tfle: 0 rta: 21069 rtaf: 0 rtf: 21059 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 8550000 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 19038
07:52:07 [ 2401.217082] rcu-torture: Reader Pipe:  135197471282 334957 0 0 0 0 0 0 0 0 0
07:52:07 [ 2401.217362] rcu-torture: Reader Batch:  121127408576 14070372577 0 0 0 0 0 0 0 0 0
07:52:07 [ 2401.217640] rcu-torture: Free-Block Circulation:  21068 21067 21066 21065 21064 21063 21062 21061 21060 21059 0
07:53:09 [ 2462.652030] rcu-torture: rtc: d00000000c0bc0c0 ver: 21699 tfle: 0 rta: 21700 rtaf: 0 rtf: 21690 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 8822126 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 19638
07:53:09 [ 2462.652417] rcu-torture: Reader Pipe:  139529124656 345192 0 0 0 0 0 0 0 0 0
07:53:09 [ 2462.652694] rcu-torture: Reader Batch:  125002324632 14527119360 0 0 0 0 0 0 0 0 0
07:53:09 [ 2462.652971] rcu-torture: Free-Block Circulation:  21699 21698 21697 21696 21695 21694 21693 21692 21691 21690 0
07:54:10 [ 2524.091285] rcu-torture: rtc: d00000000c0bc660 ver: 22353 tfle: 0 rta: 22353 rtaf: 0 rtf: 22343 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 9093588 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 20220
07:54:10 [ 2524.091585] rcu-torture: Reader Pipe:  143827878745 356129 0 0 0 0 0 0 0 0 0
07:54:10 [ 2524.091866] rcu-torture: Reader Batch:  128896137463 14932070770 0 0 0 0 0 0 0 0 0
07:54:10 [ 2524.092147] rcu-torture: Free-Block Circulation:  22352 22352 22351 22350 22349 22347 22346 22345 22344 22343 0
07:55:11 [ 2585.534608] rcu-torture: rtc: d00000000c0bcea0 ver: 22996 tfle: 0 rta: 22997 rtaf: 0 rtf: 22986 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 9363349 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 20803
07:55:11 [ 2585.534989] rcu-torture: Reader Pipe:  148169687014 366669 0 0 0 0 0 0 0 0 0
07:55:11 [ 2585.535268] rcu-torture: Reader Batch:  132812652512 15357373847 0 0 0 0 0 0 0 0 0
07:55:11 [ 2585.535546] rcu-torture: Free-Block Circulation:  22996 22995 22994 22993 22992 22990 22989 22988 22987 22986 0
07:56:13 [ 2646.973863] rcu-torture: rtc: d00000000c0bc2d0 ver: 23651 tfle: 0 rta: 23652 rtaf: 0 rtf: 23639 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 9634793 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 21403
07:56:13 [ 2646.974156] rcu-torture: Reader Pipe:  152516263894 377573 0 0 0 0 0 0 0 0 0
07:56:13 [ 2646.974437] rcu-torture: Reader Batch:  136717696712 15798916586 0 0 0 0 0 0 0 0 0
07:56:13 [ 2646.974755] rcu-torture: Free-Block Circulation:  23651 23651 23649 23648 23647 23646 23644 23642 23641 23640 0
07:57:14 [ 2708.409040] rcu-torture: rtc: d00000000c0bd140 ver: 24280 tfle: 0 rta: 24281 rtaf: 0 rtf: 24268 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 9905811 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 22003
07:57:14 [ 2708.409419] rcu-torture: Reader Pipe:  156844709742 387851 0 0 0 0 0 0 0 0 0
07:57:14 [ 2708.409695] rcu-torture: Reader Batch:  140613531217 16231537311 0 0 0 0 0 0 0 0 0
07:57:14 [ 2708.409960] rcu-torture: Free-Block Circulation:  24280 24279 24276 24275 24274 24273 24271 24270 24269 24268 0
07:58:16 [ 2769.848290] rcu-torture: rtc: d00000000c0bcf30 ver: 24877 tfle: 0 rta: 24877 rtaf: 0 rtf: 24866 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 10177536 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 22603
07:58:16 [ 2769.848664] rcu-torture: Reader Pipe:  161199176317 397631 0 0 0 0 0 0 0 0 0
07:58:16 [ 2769.848943] rcu-torture: Reader Batch:  144507369741 16692174369 0 0 0 0 0 0 0 0 0
07:58:16 [ 2769.849223] rcu-torture: Free-Block Circulation:  24876 24875 24874 24873 24872 24871 24870 24869 24867 24866 0
07:58:25 [ 2778.761119] rcu-torture: Stopping torture_shuffle task
07:58:25 [ 2778.761267] rcu-torture: Stopping torture_shuffle
07:58:25 [ 2778.761376] rcu-torture: Stopping torture_stutter task
07:58:25 [ 2778.761462] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761467] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761473] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761475] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761477] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761482] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761485] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761488] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761492] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761495] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761498] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761501] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761505] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761509] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761513] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761516] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761518] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761521] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761525] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761528] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761531] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761534] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761537] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761541] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761545] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761548] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761553] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761556] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761558] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761562] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761564] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761567] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761570] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761573] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761576] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761579] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761582] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761585] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761589] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761592] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761594] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761597] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761600] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761603] rcu-torture: Stopping torture_stutter
07:58:25 [ 2778.761606] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761609] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761611] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761614] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761618] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761620] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761623] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761626] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761630] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761633] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761636] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761639] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761642] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761645] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761648] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761650] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761653] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761655] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761657] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761659] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761662] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761664] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761666] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761668] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761670] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761672] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761675] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761677] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761679] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761680] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761683] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761685] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761687] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761688] rcu-torture: Stopping rcu_torture_writer task
07:58:25 [ 2778.761690] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761692] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761694] rcu-torture: Stopping rcu_torture_reader
07:58:25 [ 2778.761699] rcu-torture: Stopping rcu_torture_writer
07:58:25 [ 2778.761713] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761737] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761757] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761778] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761799] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761822] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761844] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761862] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761882] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761902] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761918] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761938] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761955] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761972] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.761984] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762001] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762019] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762032] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762049] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762068] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762081] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762098] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762115] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762129] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762146] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762158] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762175] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762192] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762207] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762220] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762237] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762255] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762274] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762289] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762308] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762324] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762339] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762355] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762372] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762386] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762407] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762424] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762442] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762460] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762476] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762494] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762508] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762527] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762542] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762559] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762576] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762590] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762607] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762621] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762639] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762654] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762665] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762681] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762699] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762715] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762731] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762745] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762760] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762778] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762793] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762809] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762825] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762840] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762857] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762870] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762888] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.762905] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.764122] rcu-torture: Stopping rcu_torture_fakewriter
07:58:25 [ 2778.764124] rcu-torture: Stopping rcu_torture_fakewriter
07:58:25 [ 2778.764187] rcu-torture: Stopping rcu_torture_fakewriter
07:58:25 [ 2778.764230] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764233] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764234] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764235] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764237] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764238] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764241] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764242] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764243] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.764244] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768109] rcu-torture: Stopping rcu_torture_fakewriter
07:58:25 [ 2778.768151] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768152] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768179] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768183] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768192] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768193] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768194] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768198] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768199] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.768203] rcu-torture: Stopping rcu_torture_cbflood
07:58:25 [ 2778.774986] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775058] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775126] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775191] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775256] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775320] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775388] rcu-torture: Stopping rcu_torture_reader task
07:58:25 [ 2778.775452] rcu-torture: Stopping rcu_torture_fakewriter task
07:58:25 [ 2778.775526] rcu-torture: Stopping rcu_torture_fakewriter task
07:58:25 [ 2778.775601] rcu-torture: Stopping rcu_torture_fakewriter task
07:58:25 [ 2778.775675] rcu-torture: Stopping rcu_torture_fakewriter task
07:58:25 [ 2778.775753] rcu-torture: Stopping rcu_torture_stats task
07:58:25 [ 2778.775837] rcu-torture: rtc:           (null) ver: 24968 tfle: 0 rta: 24968 rtaf: 0 rtf: 24959 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 10218404 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 22703
07:58:25 [ 2778.776064] rcu-torture: Reader Pipe:  161849976604 399197 0 0 0 0 0 0 0 0 0
07:58:25 [ 2778.776308] rcu-torture: Reader Batch:  145090807711 16759538163 0 0 0 0 0 0 0 0 0
07:58:25 [ 2778.776521] rcu-torture: Free-Block Circulation:  24967 24967 24966 24965 24964 24963 24962 24961 24960 24959 0
07:58:25 [ 2778.776741] rcu-torture: Stopping rcu_torture_stats
07:58:25 [ 2778.776800] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.776864] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.776926] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.776992] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777059] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777123] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777185] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777247] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777309] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777377] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777440] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777506] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777571] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777635] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777698] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777759] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777823] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777886] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.777948] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.778011] rcu-torture: Stopping rcu_torture_cbflood task
07:58:25 [ 2778.876118] rcu-torture: rtc:           (null) ver: 24968 tfle: 0 rta: 24968 rtaf: 0 rtf: 24959 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 10218404 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 22703
07:58:25 [ 2778.876251] rcu-torture: Reader Pipe:  161849976604 399197 0 0 0 0 0 0 0 0 0
07:58:25 [ 2778.876438] rcu-torture: Reader Batch:  145090807711 16759538163 0 0 0 0 0 0 0 0 0
07:58:25 [ 2778.876625] rcu-torture: Free-Block Circulation:  24967 24967 24966 24965 24964 24963 24962 24961 24960 24959 0
07:58:25 [ 2778.876829] rcu-torture:--- End of test: SUCCESS: nreaders=79 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
07:58:25 21:31:00 INFO | [  433.994076] rcu-torture: Reader Pipe:  1336954003 3581 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  433.994421] rcu-torture: Reader Batch:  1224323997 112633316 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  434.353580] rcu-torture: Reader Pipe:  1336954003 3581 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  434.353769] rcu-torture: Reader Batch:  1224323997 112633316 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  496.609066] rcu-torture: Reader Pipe:  2631197873 6104 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  496.609317] rcu-torture: Reader Batch:  2386634984 244568431 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  558.044599] rcu-torture: Reader Pipe:  6941790682 17017 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  558.044851] rcu-torture: Reader Batch:  6231778356 710027924 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  619.483910] rcu-torture: Reader Pipe:  11279345699 27087 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  619.484170] rcu-torture: Reader Batch:  10117105572 1162264970 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  680.923326] rcu-torture: Reader Pipe:  15627853254 38638 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  680.923606] rcu-torture: Reader Batch:  13995695481 1632193330 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  742.362778] rcu-torture: Reader Pipe:  19951131848 49929 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  742.363059] rcu-torture: Reader Batch:  17850130562 2101047363 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  803.806322] rcu-torture: Reader Pipe:  24290514367 60560 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  803.806604] rcu-torture: Reader Batch:  21752837685 2537732518 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  865.241748] rcu-torture: Reader Pipe:  28617034150 71462 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  865.242023] rcu-torture: Reader Batch:  25706841786 2910258414 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  926.685152] rcu-torture: Reader Pipe:  32935402962 82505 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  926.685412] rcu-torture: Reader Batch:  29604150841 3331328537 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  988.124719] rcu-torture: Reader Pipe:  37259723982 93240 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [  988.125001] rcu-torture: Reader Batch:  33465995956 3793814444 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1049.583808] rcu-torture: Reader Pipe:  41578723847 104315 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1049.584091] rcu-torture: Reader Batch:  37308103276 4270717226 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1110.997952] rcu-torture: Reader Pipe:  45920315848 114665 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1110.998231] rcu-torture: Reader Batch:  41182776175 4737645904 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1172.435427] rcu-torture: Reader Pipe:  50253098478 125492 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1172.435710] rcu-torture: Reader Batch:  45057226875 5195987804 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1233.877304] rcu-torture: Reader Pipe:  54575910784 135981 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1233.877589] rcu-torture: Reader Batch:  49037763663 5538272889 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1295.311274] rcu-torture: Reader Pipe:  58917621056 146529 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1295.311552] rcu-torture: Reader Batch:  52893553906 6024202609 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1356.753514] rcu-torture: Reader Pipe:  63237680606 156921 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1356.753797] rcu-torture: Reader Batch:  56781318566 6456507114 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1418.188060] rcu-torture: Reader Pipe:  67566940591 167927 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1418.188328] rcu-torture: Reader Batch:  60664172380 6902923478 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1479.630751] rcu-torture: Reader Pipe:  71902194690 179163 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1479.631031] rcu-torture: Reader Batch:  64557172348 7345188051 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1541.069396] rcu-torture: Reader Pipe:  76232938251 189785 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1541.069675] rcu-torture: Reader Batch:  68382539678 7850574108 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1602.504349] rcu-torture: Reader Pipe:  80555593817 200549 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1602.504612] rcu-torture: Reader Batch:  72254753920 8301025468 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1663.943145] rcu-torture: Reader Pipe:  84869416712 211582 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1663.943424] rcu-torture: Reader Batch:  76098105781 8771506689 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1725.382164] rcu-torture: Reader Pipe:  89190982684 222539 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1725.382438] rcu-torture: Reader Batch:  79971926419 9219262230 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1786.825199] rcu-torture: Reader Pipe:  93518648606 233164 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1786.825477] rcu-torture: Reader Batch:  83870124829 9648739597 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1848.260168] rcu-torture: Reader Pipe:  97838075377 244140 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1848.260467] rcu-torture: Reader Batch:  87750546792 10087754516 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1909.699161] rcu-torture: Reader Pipe:  102160025086 255540 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1909.699441] rcu-torture: Reader Batch:  91632035668 10528225919 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1971.138326] rcu-torture: Reader Pipe:  104868340430 262116 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 1971.138580] rcu-torture: Reader Batch:  94025881963 10842700985 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2032.581347] rcu-torture: Reader Pipe:  109182389115 271684 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2032.581631] rcu-torture: Reader Batch:  97939437624 11243202853 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2094.016599] rcu-torture: Reader Pipe:  113524450418 282217 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2094.016879] rcu-torture: Reader Batch:  101799404473 11725307174 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2155.455858] rcu-torture: Reader Pipe:  117854431015 292334 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2155.456137] rcu-torture: Reader Batch:  105647068523 12207633005 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2216.895216] rcu-torture: Reader Pipe:  122174590260 303535 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2216.895493] rcu-torture: Reader Batch:  109497475556 12677395631 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2278.334529] rcu-torture: Reader Pipe:  126525616992 314645 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2278.334810] rcu-torture: Reader Batch:  113386167123 13139741079 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2339.773726] rcu-torture: Reader Pipe:  130850209931 324989 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2339.774005] rcu-torture: Reader Batch:  117261089557 13589421074 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2401.217082] rcu-torture: Reader Pipe:  135197471282 334957 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2401.217362] rcu-torture: Reader Batch:  121127408576 14070372577 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2462.652417] rcu-torture: Reader Pipe:  139529124656 345192 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2462.652694] rcu-torture: Reader Batch:  125002324632 14527119360 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2524.091585] rcu-torture: Reader Pipe:  143827878745 356129 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2524.091866] rcu-torture: Reader Batch:  128896137463 14932070770 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2585.534989] rcu-torture: Reader Pipe:  148169687014 366669 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2585.535268] rcu-torture: Reader Batch:  132812652512 15357373847 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2646.974156] rcu-torture: Reader Pipe:  152516263894 377573 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2646.974437] rcu-torture: Reader Batch:  136717696712 15798916586 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2708.409419] rcu-torture: Reader Pipe:  156844709742 387851 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2708.409695] rcu-torture: Reader Batch:  140613531217 16231537311 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2769.848664] rcu-torture: Reader Pipe:  161199176317 397631 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2769.848943] rcu-torture: Reader Batch:  144507369741 16692174369 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2778.776064] rcu-torture: Reader Pipe:  161849976604 399197 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2778.776308] rcu-torture: Reader Batch:  145090807711 16759538163 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2778.876251] rcu-torture: Reader Pipe:  161849976604 399197 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 INFO | [ 2778.876438] rcu-torture: Reader Batch:  145090807711 16759538163 0 0 0 0 0 0 0 0 0
07:58:25 21:31:00 ERROR| Exception escaping from test:
07:58:25 Traceback (most recent call last):
07:58:25   File "/root/powerkvm-autotest/client/shared/test.py", line 411, in _exec
07:58:25     _call_test_function(self.execute, *p_args, **p_dargs)
07:58:25   File "/root/powerkvm-autotest/client/shared/test.py", line 823, in _call_test_function
07:58:25     return func(*args, **dargs)
07:58:25   File "/root/powerkvm-autotest/client/shared/test.py", line 298, in execute
07:58:25     self.postprocess()
07:58:25   File "/root/powerkvm-autotest/client/tests/rcutorture/rcutorture.py", line 116, in postprocess
07:58:25     raise error.TestError('\nBUG: rcutorture tests failed !')
07:58:25 TestError: 
07:58:25 BUG: rcutorture tests failed !
07:58:25 21:31:00 ERROR| child process failed
07:58:25 21:31:00 INFO | 		ERROR	rcutorture	rcutorture	timestamp=1481164260	localtime=Dec 07 21:31:00	
07:58:25   BUG: rcutorture tests failed !
07:58:25 21:31:00 INFO | 	END ERROR	rcutorture	rcutorture	timestamp=1481164260	localtime=Dec 07 21:31:00

--Apple-Mail=_97D09DBB-E392-413D-B230-C48EE2A68D2C--
