Message-ID: <XFMail.990425173806.hcaley@loomer.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.3.p0.Linux:990425173806:426=_"
Date: Sun, 25 Apr 1999 17:38:06 -0700 (PDT)
From: Batmensch <hcaley@loomer.com>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Linpack Benchmarks on PB G3 Series 300mhz
Cc: hcaley@loomer.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This message is in MIME format
--_=XFMail.1.3.p0.Linux:990425173806:426=_
Content-Type: text/plain; charset=us-ascii

Here are my linpack benchmarks on my PB G3 Series 300 mhz.

Hugh


----------------------------------
E-Mail: Batmensch <hcaley@loomer.com>
Date: 25-Apr-99
Time: 17:34:41

This message was sent by XFMail
----------------------------------

--_=XFMail.1.3.p0.Linux:990425173806:426=_
Content-Disposition: attachment; filename="info"
Content-Description: info
Content-Type: text/plain; charset=us-ascii; name=info; SizeOnDisk=1532
Content-Transfer-Encoding: 7bit

Linux hughmac 2.2.6-6bpmac #2 Wed Apr 21 21:02:56 PDT 1999 ppc unknown
LINPACK benchmark, Double precision.
Machine precision:  15 digits.
Array size 100 X 100.
Average rolled and unrolled performance:

    Reps Time(s) DGEFA   DGESL  OVERHEAD    KFLOPS
----------------------------------------------------
     256   0.75  69.33%   2.67%  28.00%  83753.086
     512   1.51  69.54%   2.65%  27.81%  82984.709
    1024   3.02  74.83%   5.63%  19.54%  74447.188
    2048   6.02  73.42%   5.48%  21.10%  76171.228
    4096  12.05  73.78%   4.15%  22.07%  77063.543

Enter array size (q to quit) [200]:  200
Memory required:  315K.


LINPACK benchmark, Double precision.
Machine precision:  15 digits.
Array size 200 X 200.
Average rolled and unrolled performance:

    Reps Time(s) DGEFA   DGESL  OVERHEAD    KFLOPS
----------------------------------------------------
      32   0.69  81.16%   4.35%  14.49%  74485.876
      64   1.38  84.78%   3.62%  11.59%  72043.716
     128   2.77  84.84%   2.89%  12.27%  72340.192
     256   5.52  85.87%   2.72%  11.41%  71896.387
     512  11.06  84.63%   3.44%  11.93%  72191.650

Enter array size (q to quit) [200]:  1000
Memory required:  7824K.


LINPACK benchmark, Double precision.
Machine precision:  15 digits.
Array size 1000 X 1000.
Average rolled and unrolled performance:

    Reps Time(s) DGEFA   DGESL  OVERHEAD    KFLOPS
----------------------------------------------------
       1   5.80  96.72%   0.69%   2.59%  29675.516
       2  11.53  97.48%   0.69%   1.82%  29623.086


--_=XFMail.1.3.p0.Linux:990425173806:426=_--
End of MIME message

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
