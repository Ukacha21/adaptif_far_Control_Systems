# adaptif_far_Control_Systems
Araç farlarının virajlarda direksiyonun dönüşüne bağlı olarak açılı dönemesi

**Kontrol Sistemleri Proje Raporu**


1.	İçindekiler	
2.	Genel Bilgi	
3.	Proje İle İlgili Bilgiler	

    3.1. Kullanılan Malzeme ve Ekipman	

    3.2. Projenin Mekanik Bileşenleri	

    3.3. Projenin Elektronik Donanımı

    3.4. Projenin Yazılım Mimarisi

    3.5 Sistem Modellemeleri
4.	Proje Sonuçları	
5.	Proje Sonuçlarının Yorumlanması	
6.	Kaynakça	

-----------------

## **2. Genel Bilgi**

Araç sürüş esnasında, viraja gelince direksiyonun dönüş yönü ve hızını takip ederek kordine bir sekilde farların da dönmesini amaçlayan bir proje fikridir. Böylece istikamet yönünü görebilmek için aracın bütününün dönmesine ihtiyaç kalmadan farların dinamik hareketleri sayesinde kolaylaştırılmış olur.

![](images/Picture1.png)
![](images/Picture2.png)

## **3. Proje İLE İlgili Bilgiler**


### 3.1. Kullanılan Malzeme ve Ekipman
Bu projede kullandığımız malzemeleri aşağıdaki gibi ifade edilmiştir:

![](images/maliyet.png)

### 3.2. Projenin Mekanik Bileşenleri


![](images/Picture3.png)
![](images/Picture4.png)

Ortadaki milin ucunda bulunan orta dişlisi bizim güneş dişli oluyor, onun yanındakileri sağdaki ve soldaki olmak üzere ikiye ayrılan dişliler planet dişliler oluyor.

Güneş-Planet sistemlerin çalışma prensibinde, özellikle iki dişlinin aynı yöne dönmesi hedefleniyorsa, iki dişlinin arasına 3. bir dişli daha eklenir. Bu eklenen dişli güneş dişlisi oluyor ve böylece iki planet dişli arasındaki dönüş yönü aynı olmasını sağlanmış olur.

Milin ortasına da bir adet GT2 kasnak yerleştirilecektir. Amaç, dönüş takip etmek. Bunun için de kayış-kasnak sistemin diğer ucuna bağlı 600PPR Darbeli enkodere ihtiyacımız olacaktır.


### 3.3. Projenin Elektronik Donanımı

Bu aşamada, elektronik komponentlerin bağlntı şekilleri ve birbiriyle ilişkisini gösterir `Harness Wiring Diagram’ı` ile gösterilmiştir.

![](images/Picture5.png)


### 3.4. Projenin Yazılım Mimarisi

Projemizin yazılım kısmını `Arduino IDE`’de C ve C++ programlama dilleriyle gerçekleştirdik.
Programın temel algoritmasını temsil etmek üzere, akıs şeması aşağıdaki gibidir:

![](images/Picture6.png)

### 3.5. Sistem Modelleri
    Elektromekanik Model:

![](images/Picture7.png)

## Transfer Fonskiyonu G(s)

![](images/Picture8.png)

## Simulink Diagram

![](images/Picture9.png)

## Simulink TF Çıkış Eğrisi

![](images/Picture10.png)

## Matlab TF Plot Eğrisi

![](images/Picture11.png)


## 4. PROJE Sonuçları

Proje sonunda pile taktığımız zaman sorunsuz çalıştı ama olay şu ki motor olunca ve redüktörlü olunca pili neredeyse anında boşaltacak kadar akım çekti. Pili yenisiyle değiştirdik, aynı şey oldu. Hocaya danıştıktan sonra öğrendik ki bunun gibi projelerde mümkünse deneme aşamalarında güç kaynağı kullanılır, bunun gibi aksaklıkların önüne geçmek için.


## 5. PROJE SONUÇLARININ Yorumlanması

Proje başında her ne kadar az fikir olsa da proje hakkında, tam olarak ne yapacağımızı biliyor değildik. Projenin üzerine kafa yordukça ve emek harcadıkça azar azar bilgi sahibi olduk ve genel manada kontrol sistemlerin çalışma prensiplerini anladık. 
Yapay zekanın yeterli olmadığı durumlar da oldu, özellikle dişli sistemi dönüşümü ve dönel damper rulman yatakların transfer fonksiyonundaki yerini belirlemekte yapay zeka yeterli olamamıştır. Bunun gibi durumlarda önce slaytarı detaylı inceleyerek çözüm bulmaya çalıştık. Yine de emin olmak adına aynı konu hakkında hocamıza başvurduk. 
Genel olarak başarılı ve öğretici bir proje olduğunu düşünüyoruz. Gelecekte de piyasa yeri olan bir proje eğer hayata geçirmek söz konusu olursa.

## 6. Kaynakça

https://dergi.bilgi.edu.tr/index.php/reflektif/apaStyles

https://library.ihu.edu.tr/tr/apa-kaynakca-ornekleri

Adaptive Front-Lighting System: LED Enhances Driving Safety


https://mycardoeswhat.org/safety-features/adaptive-headlights/
