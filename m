Message-ID: <37852989.5F3D914A@fi.infn.it>
Date: Fri, 09 Jul 1999 00:43:21 +0200
From: Simone Piccardi <piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: A little trouble for MVME2400 boot from HD
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I would like to boot linux on a MVME2400 from a SCSI HD; I set a primary
partition (it was /dev/sda3, about 3Mb) as 0x041 and made it bootable;
then and I copied a zImage file on it using dd. 

The ioi results for the controller are 
PPC4-Bug>ioi                                                                    
I/O Inquiry
Status:                                                             
CLUN  DLUN  CNTRL-TYPE  DADDR  DTYPE  RM 
Inquiry-Data                          
   1     0  PC8477      0      $00    Y  
<None>                                
  10    50  NCR53C825   5      $00    N   SEAGATE  ST39140W        
1487        

But when I gave:
PPC4-Bug>pboot 10 50
3                                                          

the result was: 
Booting from: NCR53C825, Controller 10, Drive
50                                
Device Name :
/pci@80000000/pci1000,3@10,0/harddisk@5,0                         
Loading: Operating
System                                                       
                                                                                
IPL Size Exceeds Free-Available
Memory:                                         
IPL Size              =AC444000
(&-1404813312)                                  
Free-Available Memory =01F74000
(&32980992)                                     

I'm missing something on the kernel image preparation? Or I have to use
another command?

Thank you in advance.

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
