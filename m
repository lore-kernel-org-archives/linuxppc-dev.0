Return-Path: <gjalt007@chello.nl>
Message-ID: <427BBA71.8040307@chello.nl>
Date: Fri, 06 May 2005 20:41:53 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: 2.4.18: CPM1 stops when initializing ATM/UTOPIA.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Last week I was trying to integrate the atm/utopia driver (sourceforce) 
into a 2.4.18 kernel build for a 862, but mij attemtps failed. It 
appeared that wen on the first location of the SCC4 (now used for 
utopia) a buffer address is written, most CPM activities are halted, 
including the SCM1 which I used as console port. The console driver did 
write in the allocated buffer descriptors, but the tranmission of the 
data was never acknowledged, thus hanging the kernel.

Anyone an idea what happened?

Theo.
